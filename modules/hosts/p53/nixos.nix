{ self, inputs, ... }: {

	flake.nixosConfigurations.p53 = inputs.nixpkgs.lib.nixosSystem {
		
		specialArgs = { inherit self inputs; };
		modules = [

			# self.nixosModules.machineConfiguration
			self.nixosModules.defaultConfiguration
			# self.nixosModules.niriConfiguration
            inputs.disko.nixosModules.disko
            ./_disko.nix

		];
	};


}
