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

        # systemd.tmpfiles.rules = [
        #     "d /home/${username}/.config/nvim/lua 0755 ${username} users -"
        #         "L+ /home/${username}/.config/nvim/lua/matugen-template.lua - - - - ${./configs/.config/nvim/lua/matugen-template.lua}"
        # ];

    };

	# perSystem = { pkg , lib, ... }: {};
}
