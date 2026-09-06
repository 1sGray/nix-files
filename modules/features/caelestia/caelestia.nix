{ self, inputs, ... }: {

	flake.nixosModules.template = { pkgs, lib, ... }: {

        environment.systemPackages = [
            inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli
        ];

    };

}
