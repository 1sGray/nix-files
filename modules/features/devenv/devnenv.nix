{ self, inputs, ... }: {

    flake.nixosModules.devenv = { }: {



        # systemd.tmpfiles.rules = [
        #     "d /home/${username}/.config/ADDPATH 0755 ${username} users -"
        #     "L+ /home/${username}/.config/ADDPATH - - - - ${./configs/ADDPATH}"
        # ];

    };

# perSystem = { pkg , lib, ... }: {};
}
