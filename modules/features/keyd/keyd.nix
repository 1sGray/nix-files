{ self, inputs, ... }: {

    flake.nixosModules.keyd = { pkgs, lib, username, ... }: {

        services.keyd = {
            enable = true;
            keyboards = {
                default = {
                    ids = [ "*" ];
                    settings = {
                        main = {
                            capslock = "overloadt(control, esc, 200)";
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
