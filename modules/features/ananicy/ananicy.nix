{ self, inputs, ... }: {
	

    flake.nixosModules.ananicy = { pkgs, ... }: {
        services.ananicy = {
            enable = true;
            package = pkgs.ananicy-cpp; # ananicy is originally a python program, the c++ rewrite uses less resources
            rulesProvider = pkgs.ananicy-rules-cachyos;
        };
    };
}
