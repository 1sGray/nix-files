{ self, inputs, ... }: {
	
	flake.nixosModules.fzf = { pkgs, lib, ... }: {
        environment.systemPackages = [
            pkgs.fzf
        ];

        programs.fzf = {
            fuzzyCompletion = true;
            # keybindings = true;
        };
    };

	# perSystem = { pkg , lib, ... }: {};
}

