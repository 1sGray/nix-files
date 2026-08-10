#!/usr/bin/env bash
#
# Automated NixOS (re)install via disko-install, picking a host config
# from modules/hosts/<device-name>/ in your nix-files flake.
#
# Run this from a booted NixOS minimal installer ISO with network access
# already set up (e.g. via `nmcli device wifi connect ...` or a plugged-in
# ethernet cable).
#
# THIS IS DESTRUCTIVE — it will completely wipe the target disk. Read the
# confirmation prompt carefully before proceeding.

set -euo pipefail

# ---- EDIT ME -------------------------------------------------------------
# Where your flake lives. A github: URI needs no local clone — recommended
# for a fresh installer ISO with nothing else on it. Use a local path
# instead if you've already got the repo checked out (e.g. from a USB
# stick), which is handy for testing changes before pushing.
FLAKE_URI="github:<your-username>/nix-files"

# The normal user to prompt a password for after install. Edit per host
# if a future host uses a different username.
USER_NAME="gray"
# ---------------------------------------------------------------------------

usage() {
    echo "Usage: $0 <host-name> <target-disk>"
    echo
    echo "  <host-name>    matches modules/hosts/<host-name> and the"
    echo "                 nixosConfigurations.<host-name> flake attribute"
    echo "  <target-disk>  e.g. /dev/nvme0n1 or /dev/sda — the WHOLE disk,"
    echo "                 not a partition"
    echo
    echo "Disks currently visible on this machine:"
    lsblk -d -o NAME,SIZE,MODEL | tail -n +2 | sed 's/^/    \/dev\//'
    exit 1
}

[ $# -eq 2 ] || usage

HOST="$1"
DISK="$2"

if [ ! -b "$DISK" ]; then
    echo "error: $DISK is not a block device" >&2
    exit 1
fi

echo "=============================================="
echo " Host:   $HOST"
echo " Flake:  ${FLAKE_URI}#${HOST}"
echo " Disk:   $DISK"
echo "=============================================="
lsblk "$DISK"
echo
echo "!!! THIS WILL COMPLETELY ERASE $DISK !!!"
read -r -p "Type the disk path again to confirm ($DISK): " CONFIRM
if [ "$CONFIRM" != "$DISK" ]; then
    echo "Confirmation did not match — aborting."
    exit 1
fi

nix \
    --extra-experimental-features "nix-command flakes" \
    run 'github:nix-community/disko/latest#disko-install' -- \
    --write-efi-boot-entries \
    --flake "${FLAKE_URI}#${HOST}" \
    --disk main "$DISK"

# disko-install leaves the new system mounted at /mnt — use that to set
# real passwords via the normal `passwd` tool before ever booting into it,
# so there's no window where the machine has locked/no-password accounts.
echo
echo "Install finished. Now set passwords for the new system."
echo

read -r -p "Set a root password too? Leaving root locked (sudo-only via $USER_NAME) is the more common/secure choice. [y/N] " SET_ROOT
if [[ "$SET_ROOT" =~ ^[Yy]$ ]]; then
    echo "Root password:"
    sudo nixos-enter --root /mnt -c 'passwd root'
fi

echo "Password for $USER_NAME:"
sudo nixos-enter --root /mnt -c "passwd $USER_NAME"

echo
echo "Passwords set. Reboot into the new system when ready: sudo reboot"
