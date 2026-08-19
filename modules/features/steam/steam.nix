{ self, inputs, ... }: {
	
	flake.nixosModules.steam = { pkgs, lib, ... }: {
        programs.steam = {
            enable = true;
            protontricks.enable = true;
            extraCompatPackages = with pkgs; [
                proton-ge-bin
            ];
        };
    };

	# perSystem = { pkg , lib, ... }: {};
}
