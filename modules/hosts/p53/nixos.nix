{ self, inputs, ... }: {

	flake.nixosConfigurations.p53 = inputs.nixpkgs.lib.nixosSystem {
		
		specialArgs = { 
            inherit self inputs;
            username = "gray";
            hostname = "p53";
        };

		modules = [

			# self.nixosModules.defaultConfiguration
			self.nixosModules.generalConfiguration
			# self.nixosModules.niriConfiguration
            inputs.disko.nixosModules.disko
            ./_disko.nix

		];
	};


}
