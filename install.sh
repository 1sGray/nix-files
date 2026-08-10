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

echo
echo "Install complete. You can reboot into it now: sudo reboot"
