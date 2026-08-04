{ self, inputs, ... }: {
	
	# flake.nixModules.template = { pkgs, lib, ... }: {};

	perSystem = { pkgs , lib, ... }: {
		packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
			inherit pkgs;
			addFlag = [ "--config" ./configs/.config/kitty/kitty.conf ];
		};
	};
}
