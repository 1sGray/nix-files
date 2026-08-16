{ self, inputs, ... }: {

	flake.nixosModules.noctalia = { pkgs, lib, ... }:{

		environment.systemPackages = [
			self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
            pkgs.noctalia-qs
            pkgs.python3
		];

		# programs.myNoctalia = {
		# 	enable = true;
		# };
	};

	perSystem = { pkgs, ... }: {
		packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
			inherit pkgs;

            # Still useful as the one-time seed for a fresh machine / fresh clone.
			settings = (builtins.fromJSON (builtins.readFile ./config/noctalia.json) ).settings;

            # Points NOCTALIA_CONFIG_DIR at a real, persistent, git-tracked path.
            # Must be a genuine absolute filesystem path — not a Nix path literal —
            # since the whole point is that it's NOT copied into the store.
            outOfStoreConfig = "/home/gray/nix-files/modules/features/noctalia/config";

		};
	};
}
