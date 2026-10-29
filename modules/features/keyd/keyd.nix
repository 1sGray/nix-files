{ self, inputs, ... }: {

    flake.nixosModules.keyd = { pkgs, lib, username, ... }: {

        services.keyd = {
            enable = true;
            keyboards = {
                default = {
                    ids = [ "*" ];
                    settings = {
                        main = {
                            capslock = "overloadt2(control, esc, 125)";
                        };
                    };
                };
            };
        };
        # systemd.tmpfiles.rules = [
        #     "d /home/${username}/.config/ADDPATH 0755 ${username} users -"
        #     "L+ /home/${username}/.config/ADDPATH - - - - ${./configs/ADDPATH}"
        # ];

    };

# perSystem = { pkg , lib, ... }: {};
}
