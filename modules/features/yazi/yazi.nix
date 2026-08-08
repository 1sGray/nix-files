{ self, inputs, ... }: {

	flake.nixosModules.yazi = { pkgs, lib, self, inputs, ... }:{

		# environment.systemPackages = [
		# 	self.packages.${pkgs.stdenv.hostPlatform.system}.myYazi
		# ];

		programs.yazi = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.myYazi;

		};

	};

	perSystem = { pkgs, self, lib, ... }: {
		packages.myYazi = inputs.wrapper-modules.wrappers.yazi.wrap {
			inherit pkgs;
            constructFiles.generatedConfig.content = lib.mkForce (
                builtins.readfile ./configs/.config/yazi/config.toml
            );
		};
	};
}
