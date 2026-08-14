# modules/hosts/<device-name>/disko.nix
#
# Declarative disk layout, consumed by `disko-install`.
#
# The disk is named "main" here on purpose — you never hardcode the real
# /dev path in this file. At install time you pass the actual device with
# `--disk main /dev/sdX`, so this same file works no matter which physical
# drive ends up in the machine.
#
# Copy this into modules/hosts/<device-name>/disko.nix per host and adjust
# sizes/filesystems as needed for that machine.

{ ... }:

{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/nvme-KBG40ZNS256G_NVMe_KIOXIA_256GB_50IPGESXPTLL"; # overwritten by --disk main <device> at install time
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            # BIOS boot partition for grub's efiSupport + useOSProber setup.
            # Harmless to keep even on a pure-UEFI install.
            BIOS = {
              type = "EF02";
              size = "1M";
              priority = 1;
            };

            ESP = {
              type = "EF00";
              # NOTE: your old ESP was 1G and it still filled up with just
              # 2 generations of the LTO+nvidia kernel (815M in /boot/kernels
              # alone, plus 195M in /boot/EFI). Since you're repartitioning
              # from scratch anyway, this is the moment to fix that —
              # sized up here to 2G. Adjust if you know you need more/less.
              size = "2G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            swap = {
              # Match this to whatever your current on-disk swap partition
              # size is (separate from your zram swap) — check your existing
              # hardware-configuration.nix / swapDevices for the current value.
              size = "8G";
              content = {
                type = "swap";
                discardPolicy = "both";
              };
            };

            root = {
              size = "100%";
              content = {
                type = "filesystem";
                # You already list btrfs in boot.supportedFilesystems —
                # switch to "ext4" here if you'd rather keep it simple.
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
