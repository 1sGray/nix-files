{ self, inputs, ... }: {
	
	flake.nixosModules.kitty = { pkgs, lib, ... }: {

		environment.systemPackages = [
			# self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty
            pkgs.kitty
		];

        environment.etc."xdg/kitty/kitty.conf".source = ./configs/.config/kitty/kitty.conf;

	};

	perSystem = { pkgs , lib, ... }: {
		packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
			inherit pkgs;
            extraConfig = builtins.readFile ./configs/.config/kitty/kitty.conf;
		};
	};
}
