{ self, inputs, ... }: {

    flake.nixosModules.lutris = { pkgs, lib, ... }: {
        environment.systemPackages = with pkgs; [
            (lutris.override {
             extraLibraries = pkgs: [ /* missing libraries */ ];
             extraPkgs = pkgs: [ /* missing packages */ ];
             })
        ];
    };

# perSystem = { pkg , lib, ... }: {};
}
