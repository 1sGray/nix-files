{ self, inputs, ... }: {
	
	flake.nixosModules.fastfetch = {
	};

	perSystem = { pkgs, lib, self, .... }: {
		packages.myfastfetch = inputs.wrapper-modules.wrappers.fastfetch.wrap {
			inherit pkgs;
			# settings.config_dirctory = ./configs/.config/fastfetch;
		};
}
