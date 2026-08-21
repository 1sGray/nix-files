{ self, inputs, ... }: {
	
	flake.nixosModules.nixCrab = { pkgs, lib,... }: {

        imports = [ inputs.nix-crab.nixosModules.default ];
        programs.nix-crab.slssteam.enable = true;
        # programs.steam.enable = true;
        programs.nix-crab.millennium = {

            enable = true;      # optional

            # plugins = [
            #     "e73371b61eef" # Size On Disk
            # ];
            # themes  = [
            #     "8YTvx3fAAfwQSu6MNOfH" # OldSteam
            # ];

        };
    };
	# perSystem = { pkg , lib, ... }: {};
}

