{ self, inputs, ... }: {
	
	flake.nixosModules.zsh = { self, inputs, pkgs, ... }: {

		environment = {
			systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.myZsh ];
			pathsToLink = [ "/share/zsh" ];
		};

		programs.zsh.enable = true;

	};
	perSystem = { pkgs, lib, self, ... }: {
		packages.myZsh = inputs.wrapper-modules.wrappers.zsh.wrap {

			inherit pkgs;

			zdotdir = ./configs/.config/zsh;
			skipGlobalRC = true;
			hmSessionVariables = null;
		};

	};

}
