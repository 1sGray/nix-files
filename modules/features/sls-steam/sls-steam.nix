{ self, inputs, ... }: {
	
	flake.nixosModules.slsSteam = { pkgs, lib, username, ... }: let

        # # Build a 64-bit version of SLSsteam
        # slssteam64 = inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.sls-steam.overrideAttrs (old: {
        #     buildPhase = ''
        #         dotnet build -c Release -r linux-x64
        #     '';
        #     installPhase = ''
        #         mkdir -p $out/lib
        #         cp bin/Release/net6.0/linux-x64/publish/SLSsteam.so $out/lib/SLSsteam64.so
        #     '';
        # });

        slssteam64 = pkgs.stdenv.mkDerivation {
            name = "slssteam64";
            src = builtins.fetchurl {
                url = "https://github.com/AceSLS/SLSsteam/releases/latest/download/SLSsteam64.so";
                sha256 = "sha256-IItrdb7Puk05RqOBWZYFC5X6Wl1sJmCfh5MWVHw5iMM"; 
            };
            dontUnpack = true;
            installPhase = ''
                mkdir -p $out/lib
                cp $src $out/lib/SLSsteam64.so
            '';
        };

    in{

        programs.steam = {
            package = pkgs.steam.override {
                extraEnv = {
                    LD_PRELOAD = "${slssteam64}/lib/SLSsteam64.so";
                };
            };
        };


        # systemd.tmpfiles.rules = [
        #     # Create the SLSsteam config directory if missing
        #     "d /home/${username}/.config/SLSsteam 0755 ${username} users -"
        #
        #     # Symlink your config.yaml ONLY if the destination does NOT exist (L vs L+)
        #     "L /home/${username}/.config/SLSsteam/config.yaml - - - - ${./configs/.config/SLSsteam/config.yaml}"
        # ];

    };

	# perSystem = { pkg , lib, ... }: {};
}
