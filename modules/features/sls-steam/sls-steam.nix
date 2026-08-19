{ self, inputs, ... }: {
	
	flake.nixosModules.slsSteam = { pkgs, lib, ... }: {
        programs.steam = {
            package = pkgs.steam.override {
                extraEnv = {
                    LD_AUDIT = "${
                        inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.sls-steam
                    }/library-inject.so:${
                        inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.sls-steam
                    }/SLSsteam.so";
                };
            };
        };
    };

	# perSystem = { pkg , lib, ... }: {};
}
