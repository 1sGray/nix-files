{ self, inputs, ... }: {

    flake.nixosModules.keyd = { pkgs, lib, username, ... }: {

        services.keyd = {
            enable = true;
            keyboards = {
                default = {
                    ids = [ "*" ];
                    settings = {
                        main = {
                            capslock = "overload(control, esc)";
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
