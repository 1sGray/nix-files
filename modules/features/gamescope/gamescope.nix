{ self, inputs, ... }: {

	flake.nixosModules.gamescope = { pkgs, lib, ... }: {
		programs.gamescope = {
			enable = true;
			capSysNice = true;
		};
	};

	# perSystem = { pkg , lib, ... }: {};
}
