{ ... }: {

    flake.nixosModules.devenv = { pkgs, ... }: {

        environment.systemPackages = [
            pkgs.devenv
        ];

        # systemd.tmpfiles.rules = [
        #     "d /home/${username}/.config/ADDPATH 0755 ${username} users -"
        #     "L+ /home/${username}/.config/ADDPATH - - - - ${./configs/ADDPATH}"
        # ];

    };

# perSystem = { pkg , lib, ... }: {};
}
