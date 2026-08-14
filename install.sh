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
FLAKE_URI="github:1sGray/nix-files"

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
FLAKE_REF="${FLAKE_URI}#${HOST}"

if [ ! -b "$DISK" ]; then
    echo "error: $DISK is not a block device" >&2
    exit 1
fi

echo "=============================================="
echo " Host:   $HOST"
echo " Flake:  $FLAKE_REF"
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

# The live ISO's root is a RAM-backed tmpfs overlay, capped smaller than
# your actual RAM by default — fetching/building the closure for install
# can run it out of space well before your disk is even involved. Give it
# more headroom up front; this is a no-op if the mountpoint doesn't match
# on your particular ISO version, so it's safe to always attempt.
echo "Giving the live session's overlay more room..."
sudo mount -o remount,size=90% /nix/.rw-store 2>/dev/null \
    || sudo mount -o remount,size=90% / 2>/dev/null \
    || true

echo
echo "Partitioning, formatting, and installing to $DISK..."
sudo nix \
    --extra-experimental-features "nix-command flakes" \
    run 'github:nix-community/disko/latest#disko-install' -- \
    --write-efi-boot-entries \
    --flake "$FLAKE_REF" \
    --disk main "$DISK"

# disko-install unmounts /mnt automatically once it finishes successfully —
# remount (not reformat) the same partitions so we can chroot in and set
# passwords before ever rebooting into an account-less system.
echo
echo "Remounting the new install to set passwords..."
sudo nix \
    --extra-experimental-features "nix-command flakes" \
    run 'github:nix-community/disko/latest#disko-install' -- \
    --mode mount \
    --flake "$FLAKE_REF" \
    --disk main "$DISK"

mount | grep -q " /mnt " || {
    echo "error: /mnt didn't come back mounted after install." >&2
    echo "Mount it manually (see 'lsblk $DISK' for partitions) then run:" >&2
    echo "  sudo nixos-enter --root /mnt -c 'passwd root'" >&2
    echo "  sudo nixos-enter --root /mnt -c 'passwd $USER_NAME'" >&2
    exit 1
}

echo
read -r -p "Set a root password too? Leaving root locked (sudo-only via $USER_NAME) is the more common/secure choice. [y/N] " SET_ROOT
if [[ "$SET_ROOT" =~ ^[Yy]$ ]]; then
    echo "Root password:"
    sudo nixos-enter --root /mnt -c 'passwd root'
fi

echo "Password for $USER_NAME:"
sudo nixos-enter --root /mnt -c "passwd $USER_NAME"

echo
echo "=============================================="
echo " Passwords set. Reboot into the new system when ready: sudo reboot"
echo " (remove the install media first)"
echo
echo " Reminder: if _disko.nix for $HOST still has a"
echo " /dev/disk/by-id/CHANGE_ME placeholder, update it with the real"
echo " by-id path (ls -l /dev/disk/by-id/ | grep \$DISKNAME) before your"
echo " first 'nixos-rebuild switch' from inside the installed system —"
echo " otherwise grub will fail to reinstall the bootloader on rebuild."
echo "=============================================="
