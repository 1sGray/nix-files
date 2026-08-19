{ self, inputs, ... }: {
	
	flake.nixosModules.steam = { pkgs, lib, ... }: {
        programs.steam = {
            enable = true;
            protontricks.enable = true;
            extraCompatPackages = with pkgs; [
                proton-ge-bin
            ];
        };
        hardware.graphics.enable32Bit = true;
    };

	# perSystem = { pkg , lib, ... }: {};
}
