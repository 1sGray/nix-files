{ self, inputs, ... }: {

	flake.nixosModules.myGrub = { pkgs, inputs, config, ...}: {
		boot.loader.grub = {
			minegrub-world-sel = {
				enable = true;
				customIcons = with config.system; [
					{
						inherit name;
						#lineTop = with nixos; distroName + " " + codeName = " (" + version + ")";
						lineBottom = "Survival Mode, No Cheats, Version: " nixos.release;
						imgName = "nixos";
					}
				];
			};
		};
		# modules = [
		# 	inputs.minegrub-world-sel-theme.nixosModules.default
		# ];
	};
}
