{ self, inputs, ... }: {
	
	flake.nixosModules.neovim = {
		programs.neovim = { pkgs, lib, ... }: {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim;
		};
	};
	
	perSystem = { pkgs, ... }: {
		packages.myNeovim = inputs.wrapper-modules.wrappers.neovim.wrap {
			inherit pkgs;
			settings.config_directory = ./config/.config/nvim;
		};
	};

}
