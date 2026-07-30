{ self, inputs, lib, wlib, ... }: {
	# imports = [ inputs.wrapper-modules.flakeModules.wrappers ];

	# flake.nixosModules.zellij = { pkgs, lib, self', ... }: {
	# 	programs.zellij = {
	# 		enable = true;
	# 		package = self'.packages.myZellij;
	# 	};
	# };
	
	perSystem = { pkgs, lib, wlib, config, inputs', self', ... }: {

		packages.myZellij = inputs'.wrapper-modules.lib.wrapPackages ({ config, lib, pkgs, ... }: {
			inherit pkgs;

			# imports = [ wlib.modules.default ];



			options.settings.config_directory = lib.mkOption {
				type = lib.types.path;
				default = ./configs/.config/zellij;
				description = "Directory containing config.kdl and layouts/ for zellij.";
			};
			package = inputs'.zellij.packages.default;
			# config.package = lib.mkDefault pkgs.zellij;
			config.envDefault.ZELLIJ_CONFIG_DIR = "${config.settings.config_directory}";
		});
	};
}
