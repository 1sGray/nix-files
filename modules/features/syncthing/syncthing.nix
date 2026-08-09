{ self, inputs, pkgs, ... }: {

# You can find Syncthing's option in: https://mynixos.com/nixpkgs/options/services.syncthing
    flake.nixosModules.syncthing = { pkgs, ... }: {
       services.syncthing = {
           enable = true;
           systemService = true;
           package = pkgs.syncthing;
        };
    };

}
