{ self, inputs, ... }: {

	flake.nixosModules.gamescope = { pkgs, lib, ... }: {

        environment.systemPackages = with pkgs; [
            
            gamescope
            # gamescope-wsi
        ];

		# programs.gamescope = {
		# 	enable = true;
		# 	capSysNice = true;
		# };
	};

	# perSystem = { pkg , lib, ... }: {};
}
