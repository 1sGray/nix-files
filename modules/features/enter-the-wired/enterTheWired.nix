{ self, inputs, ... }: {

    flake.nixosModules.accela = { pkgs, lib, ... }: {
        environment.systemPackages = [
          inputs.enter-the-wired.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
    };
}
