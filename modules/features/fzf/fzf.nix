{ self, inputs, ... }: {
	
	flake.nixosModules.fzf = { pkgs, lib, ... }: {
        envionment.systemPackages = [
            pkgs.fzf
        ];

        programs.fzf = {
            fuzzyCompletion = true;
            # keybindings = true;
        };
    };

	# perSystem = { pkg , lib, ... }: {};
}

