{ self, inputs, ... }: {

    flake.nixosModules.bottles = { pkgs, lib, username, ... }: {

        environment.systemPackages = [
            pkgs.bottles
        ];
        # systemd.tmpfiles.rules = [
        #     "d /home/${username}/.config/ADDPATH 0755 ${username} users -"
        #     "L+ /home/${username}/.config/ADDPATH - - - - ${./configs/ADDPATH}"
        # ];

    };

# perSystem = { pkg , lib, ... }: {};
}
