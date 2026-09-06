{ self, inputs, ... }: {

	flake.nixosModules.caelestiaShell = { pkgs, lib, ... }: {

        environment.systemPackages = [
            inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli
        ];

    };

}
