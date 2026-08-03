{ self, inputs, ... }: {
	
	flake.nixModules.starship = { pkgs, self, ... }: let
		currentSystem = pkgs.stdenv.hostPlatform.system;
	in{
		envirnoment.systemPackages = [ self.packages.${currentSystem}.myStarship ];
	};
	
	perSystem = { pkgs, lib, self, ... }: {
		packages.myStarshipPrompt = inputs.wrapper-modules.wrappers.starship.wrap {
			inherit pkgs;
			env.STARSHIP_CONFIG = lib.mkForce (toString ./configs/.config/starship.toml);
		};
	};
}
