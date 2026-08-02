{ self, inputs, ... }: {
	
	flake.nixModules.template = { pkgs, lib, ... }: {};

	perSystem = { pkg , lib, ... }: {};
}
