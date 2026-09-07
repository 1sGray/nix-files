# modules/features/yazi/yazi.nix
{ self, inputs, ... }: {

    flake.nixosModules.yazi = { pkgs, lib, username, ... }:{

        programs.yazi = {

            enable = true;

            plugins = {
                # ".yazi" = pkgs.yaziPlugins.

                full-border = pkgs.yaziPlugins.full-border;
                mount =       pkgs.yaziPlugins.mount;

            };
        };

    };

}
