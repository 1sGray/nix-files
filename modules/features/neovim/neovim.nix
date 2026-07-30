{ self, inputs, ... }: {
	
	flake.nixosModules.neovim = { pkgs, lib, ... }: {
		programs.neovim = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim;
		};
	};
	
	perSystem = { pkgs, ... }: {
		packages.myNeovim = inputs.wrapper-modules.wrappers.neovim.wrap {
			inherit pkgs;
			settings.config_directory = ./configs/.config/nvim;
		};
	};

}
