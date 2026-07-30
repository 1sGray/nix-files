{ self, inputs, ... }: {

	flake.nixosModules.zellij = { pkgs, lib, ... }: {
		programs.zellij = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.zellij;
		};
	};
	
	perSystem = { pkgs, lib, wlib, config, ... }: {

		packages.zellij = inputs.wrapper-modules.wrappers.zellij {
			inherit pkgs;

			imports = [ wlib.modules.default ];

			options.settings.config_directory = lib.mkOption {
				type = lib.types.path;
				default = ./configs/.config/zellij;
				description = "Directory containing config.kdl and layouts/ for zellij.";
			};

			# config.package = lib.mkDefault pkgs.zellij;
			config.envDefault.ZELLIJ_CONFIG_DIR = "${config.settings.config_directory}";
		};
	};

}
