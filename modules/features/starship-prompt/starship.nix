{ self, inputs, ... }: {
	
	flake.nixosModules.starship = { pkgs, self, ... }: let
		currentSystem = pkgs.stdenv.hostPlatform.system;
	in{
		environment.systemPackages = [ self.packages.${currentSystem}.myStarship ];
	};
	
	perSystem = { pkgs, lib, self, ... }: {
		packages.myStarship = inputs.wrapper-modules.wrappers.starship.wrap {
			inherit pkgs;
			env.STARSHIP_CONFIG = lib.mkForce (toString ./configs/.config/starship.toml);
		};
	};
}
