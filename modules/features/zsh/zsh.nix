{ self, inputs, ... }: {
	
	perSystem = { pkgs, lib, self, ... }: {
		packages.myZsh = inputs.wrapper-modules.wrappers.zsh.wrap {

			inherit pkgs;


		};

	};

}
