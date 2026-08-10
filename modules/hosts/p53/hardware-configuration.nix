{ self, inputs, ... }: {
	flake.nixosModules.machineHardware = { config, lib, pkgs, modulesPath, ... }: {
		imports = [
			(modulesPath + "/installer/scan/not-detected.nix")
		];

		boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
		boot.initrd.kernelModules = [ ];
		boot.kernelModules = [ "kvm-intel" ];
		boot.extraModulePackages = [ ];

		# fileSystems."/" = {
		# 	device = "/dev/disk/by-uuid/7bb25474-08b9-438a-a4d9-608cf3042e9c";
		# 	fsType = "ext4";
		# };
		#
		# fileSystems."/boot" = {
		# 	device = "/dev/disk/by-uuid/C298-FC99";
		# 	fsType = "vfat";
		# 	options = [ "fmask=0077" "dmask=0077" ];
		# };
		#
		# swapDevices = [
		# 	{ device = "/dev/disk/by-uuid/0f584038-6433-497d-bcab-fce9902d7d06"; }
		# ];

		nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
		hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	};
}
