{ self, inputs, lib, wlib, ... }: {
	# imports = [ inputs.wrapper-modules.flakeModules.wrappers ];

	flake.nixosModules.zellij = { pkgs, lib, self', ... }: {

		# program.zellij = {
		# 	enable = true;
		# 	package = self.packages.${pkgs.stdenv.hostPlatform.system}.myZellij;
		# };

		environment.systemPackages = [
			# self.packages.myZellij 
			self.packages.${pkgs.stdenv.hostPlatform.system}.myZellij
			# self'.packages.myZellij
		];

	};
	
	perSystem = { pkgs, ... }: {

		# packages.myZellij = inputs'.wrapper-modules.lib.wrapPackages ({ config, lib, pkgs, ... }: {
		# 	inherit pkgs;
		#
		# 	# imports = [ wlib.modules.default ];
		#
		#
		#
		# 	options.settings.config_directory = lib.mkOption {
		# 		type = lib.types.path;
		# 		default = ./configs/.config/zellij;
		# 		description = "Directory containing config.kdl and layouts/ for zellij.";
		# 	};
		# 	package = inputs'.zellij.packages.default;
		# 	# config.package = lib.mkDefault pkgs.zellij;
		# 	config.envDefault.ZELLIJ_CONFIG_DIR = "${config.settings.config_directory}";
		# });

		packages.myZellij = pkgs.symlinkJoin {
			name = "zellij";
			paths = [ pkgs.zellij ];
			nativeBuildInputs = [ pkgs.makeWrapper ];
			postBuild = ''
				wrapProgram $out/bin/zellij \
					--set-default ZELLIJ_COFIG_DIR ${./configs/.config/zellij}
			'';
		};
	};
}
