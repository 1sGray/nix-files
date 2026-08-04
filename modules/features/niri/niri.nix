{ self, inputs, ... }: {

	flake.nixosModules.niri = { pkgs, lib, ... }: {
		programs.niri = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
		};
	};
	
	perSystem = { pkgs, lib, self', ... }: {
		packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
			inherit pkgs;
			"config.kdl".path = ./configs/.config/niri/config.kdl;
			# settings = {
			# 	spawn-at-startup = [
			# 		(lib.getExe self'.packages.myNoctalia)
			# 	];
			#
			# 	xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
			#
			# 	input = {
			#
			# 		keyboard = {
			# 		xkb.layout = "us";
			# 		};
			#
			# 		touchpad = {
			# 			click-method = "clickfinger";
			# 			tap = _: { };
			# 			natural-scroll = _: { };
			# 			dwt = _: { }; # disable while typing
			# 			dwtp = _: { }; # disable while trackpointing
			# 		};
			# 	};
			#
			# 	layout.gaps = 5;
			#
			# 	binds = {
			# 		"Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
			# 		"Mod+Q".close-window = _:{};
			# 		#"Mod+Q".close-window = null;
			# 		"Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle"; 
			# 	};
			# };
		};
	};
}
