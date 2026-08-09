{ self, inputs, ... }: {
	
	flake.nixosModules.keepassxc = { pkgs, lib, ... }: {

	       environment.systemPackages = with pkgs; [
	           keepassxc

	       ];
	};
	
	# perSystem = { pkgs, ... }: {
	# 	packages.myKeepass = inputs.wrapper-modules.wrappers.neovim.wrap {
	# 		inherit pkgs;
	# 		settings.config_directory = ./configs/.config/nvim;
	# 	};
	# };

}

