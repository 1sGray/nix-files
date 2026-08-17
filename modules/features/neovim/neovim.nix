{ self, inputs, ... }: {
	
	flake.nixosModules.neovim = { pkgs, lib, config, username, ... }: {
		programs.neovim = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim;
		};

         systemd.tmpfiles.rules = [
            "d /home/${username}/.config/nvim/lua 0755 ${username} users -"
            "L+ /home/${username}/.config/nvim/lua/matugen-template.lua - - - - ${./configs/.config/nvim/lua/matugen-template.lua}"
        ];

	};
	
	perSystem = { pkgs, ... }: {
		packages.myNeovim = inputs.wrapper-modules.wrappers.neovim.wrap {
			inherit pkgs;
			settings.config_directory = ./configs/.config/nvim;
		};
	};

}
