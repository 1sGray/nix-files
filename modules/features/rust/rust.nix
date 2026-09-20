{ self, inputs, ... }: {

    flake.nixosModules.rust = { pkgs, lib, ... }: {
            environment.systemPackages = with pkgs; [ 
                rustup
                rust-analyzer
            ];
        };

# perSystem = { pkg , lib, ... }: {};
}
