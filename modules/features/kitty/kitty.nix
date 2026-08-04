{ self, inputs, ... }: {
	
	flake.nixModules.kitty = { pkgs, lib, ... }: {
		environment.systemPackages = [
			self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty
		];
	};

	perSystem = { pkgs , lib, ... }: {
		packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
			inherit pkgs;
			addFlag = [ "--config" ./configs/.config/kitty/kitty.conf ];
		};
	};
}
