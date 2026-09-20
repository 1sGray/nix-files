{ self, inputs, ... }: {

    flake.nixosModules.freesmLauncher = { pkgs, inputs, ... }: {

        environment.systemPackages = [
            inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.freesmlauncher

        ];
    };

# perSystem = { pkg , lib, ... }: {};
}
