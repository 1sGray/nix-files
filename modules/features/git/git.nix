{ self, inputs, ... }: {

    flake.nixosModules.git = { pkgs, lib, username, ... }: {

            # Programs.git.config = [
            #     init = {
            #             defaultBranch = "main";
            #     };
            #     user = {
            #             name = "gray";
            #             email = "1s_gray@proton.com"
            #         };
            # ];

        systemd.tmpfiles.rules = [
            # Symlink your config.yaml ONLY if the destination does NOT exist (L vs L+)
            "L /home/${username}/.gitconfig - - - - ${./configs/.gitconfig}"
        ];

    };

# perSystem = { pkg , lib, ... }: {};
}
