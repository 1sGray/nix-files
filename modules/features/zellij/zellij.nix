{ self, inputs, ... }: {
	imports = [ inputs.wrapper-modules.flakeModules.wrappers ];

	flake.nixosModules.zellij = { pkgs, lib, self', ... }: {
		programs.zellij = {
			enable = true;
			package = self'.packages.myZellij;
		};
	};
	
	perSystem = { pkgs, lib, wlib, config, inputs', ... }: {

		packages.myZellij = inputs'.wrapper-modules.wrappers.zellij.wrap {
			inherit pkgs;

			imports = [ wlib.modules.default ];

			options.settings.config_directory = lib.mkOption {
				type = lib.types.path;
				default = ./configs/.config/zellij;
				description = "Directory containing config.kdl and layouts/ for zellij.";
			};

			config.package = lib.mkDefault pkgs.zellij;
			config.envDefault.ZELLIJ_CONFIG_DIR = "${config.settings.config_directory}";
		};
	};
}
