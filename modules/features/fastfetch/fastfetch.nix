{ self, inputs, ... }: {
	
	flake.nixosModules.fastfetch = { self', inputs, pkgs, ... }: {
		environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.myFastfetch ];
	};

	perSystem = { pkgs, lib, self, ... }: {
		packages.myFastfetch = inputs.wrapper-modules.wrappers.fastfetch.wrap {
			inherit pkgs;
			# appendFlag = [
			# 	[ "--config" ./configs/.config/fastfetch ]
			# ];
		};
	};
}
