{ self, inputs, ... }: {

	flake.nixosModules.mangohud = { pkgs, ... }: {
		environment.systemPackages = [ pkgs.mangohud ];
	};

	# perSystem = { pkg , lib, ... }: {};
}
