{ self, inputs, ... }: {

    flake.nixosModules.java = { pkgs, lib, ... }: {
        programs.java = {
            enable = true;
            package = pkgs.jdk21; # Or pkgs.jdk, pkgs.jdk11, etc.
        };
    };

# perSystem = { pkg , lib, ... }: {};
}
