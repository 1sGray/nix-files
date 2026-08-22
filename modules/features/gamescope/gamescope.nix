{ self, inputs, ... }: {

	flake.nixosModules.gamescope = { pkgs, lib, ... }: {
		programs.gamescope = {
			enable = true;
			capSysNice = false;
		};
	};

	# perSystem = { pkg , lib, ... }: {};
}
