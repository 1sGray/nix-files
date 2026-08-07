# zram.nix
{ ... }: {
  flake.nixosModules.zram = { config, lib, pkgs, ... }: {

    # Enables zram-backed swap using the zram-generator systemd service.
    zramSwap = {
      enable = true;

      # Compression algorithm. zstd gives the best ratio for a modest
      # CPU cost; lz4 is faster but compresses less. zstd is a good
      # default on anything from the last several years.
      algorithm = "zstd";

      # How much RAM to devote to the compressed swap device, as a
      # percentage of total RAM. 50% is a common default: on a 16GB
      # system that's an 8GB zram device, which (at ~2-3x compression)
      # can absorb well beyond 8GB of actual swapped data.
      # Bump this higher (e.g. 100-150) on low-RAM machines where
      # avoiding disk swap matters more; lower it on RAM-rich systems
      # where you rarely swap at all.
      memoryPercent = 50;

      # Swap priority. Higher number = preferred first. Set this above
      # any disk-based swap device/file so zram is used before disk.
      priority = 100;
    };

    # Optional: make the kernel reach for swap a bit more eagerly than
    # the default, since zram swap is cheap (fast, RAM-resident) rather
    # than costly disk I/O. Lower swappiness (default is often ~60) if
    # you'd rather the kernel avoid swapping until necessary; raise it
    # if you want it to lean on zram more.
    boot.kernel.sysctl."vm.swappiness" = 100;
  };
}
