{ self, inputs, ... }: {
	
	flake.nixosModules.nixCrabSteam = { pkgs, lib, username, ... }: {

        imports = [ inputs.nix-crab.nixosModules.default ];
        programs.nix-crab.slssteam.enable = true;

        # programs.nix-crab.millennium = {
        #     enable = false;      # optional
        # };

        programs.steam = {

            enable = true;

            protontricks.enable = true;

            extraCompatPackages = with pkgs; [
                proton-ge-bin
            ];

            # package = pkgs.steam.override {
            #     extraEnv = {
            #         __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            #         __NV_PRIME_RENDER_OFFLOAD = "1";
            #         __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
            #         __VK_LAYER_NV_optimus = "NVIDIA_only";
            #     };
            # };

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

