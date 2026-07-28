{ self, inputs, ... }: {
	self.nixosModules.myGrub { pkgs, inputs, ...}: {
		modules = [
			inputs.minegrub-world-sel-theme.nixosModules.default
		];
	};
}
