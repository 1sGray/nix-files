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


            # Import configs directly from your local files
            settings = {
                yazi = lib.importTOML ./configs/.config/yazi/yazi.toml;
                keymap = lib.importTOML   ./configs/.config/yazi/keymap.toml;
                # theme = lib.importTOML    ./configs/.config/yazi/theme.toml;
            };

            # If you need to initialize a Lua script
            # initLua = builtins.readFile ./configs/.config/yazi/init.lua;

        };

    };

}
