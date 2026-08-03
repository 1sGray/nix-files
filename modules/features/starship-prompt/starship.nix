{ self, inputs, ... }: {
	
	perSystem = { pkgs, lib, ... }: {
		packages.myStarshipPrompt = inputs.wrapper-modules.wrappers.starship.wrap {
			inherit pkgs;

		};
	};
}
