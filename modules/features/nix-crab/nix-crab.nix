{ self, inputs, ... }: {
	
	flake.nixosModules.nixCrab = { pkgs, lib, username, ... }: {

        imports = [ inputs.nix-crab.nixosModules.default ];
        programs.nix-crab.slssteam.enable = true;
        # programs.steam.enable = true;
        programs.nix-crab.millennium = {
            enable = true;      # optional
        };

        systemd.tmpfiles.rules = [
            # Create the SLSsteam config directory if missing
            "d /home/${username}/.config/SLSsteam 0755 ${username} users -"

            # Symlink your config.yaml ONLY if the destination does NOT exist (L vs L+)
            "L /home/${username}/.config/SLSsteam/config.yaml - - - - ${./configs/.config/SLSsteam/config.yaml}"
        ];

    };
	# perSystem = { pkg , lib, ... }: {};
}

