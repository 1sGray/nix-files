{ self, inputs, ... }: {

	flake.nixosModules.noctalia = { pkgs, lib, ... }: let 

		#       hyprDir = "/home/${username}/.config/hypr";
		# hyprConfigs = ./configs/.config/hypr;
		# mkLink = name: "L+ ${hyprDir}/${name} - ${username} users - ${hyprConfigs}/${name}";

    in {

		# environment.systemPackages = [
		#         inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
		# ];

        imports = [
            inputs.noctalia.nixosModules.default
        ];

        programs.noctalia = {
            enable = true;

            # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
            recommendedServices.enable = true;
        };

        nix.settings = {
            extra-substituters = [ "https://noctalia.cachix.org" ];
            extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
        };

		#       systemd.tmpfiles.rules = [
		# 	"d ${hyprDir} 0755 ${username} users -"
		# ] ++ map mkLink [
		#
		# ];

	};

}
