{ self, inputs, ... }: {

	flake.nixosModules.noctalia = { pkgs, lib, ... }:{

		environment.systemPackages = [
			self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
		];

		# programs.myNoctalia.enable = true;
	};

	perSystem = { pkgs, ... }: {
		packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
			inherit pkgs;
			settings = (builtins.fromJSON
				(builtins.readFile ./config/noctalia.json)
			).settings;
		};
	};
}
