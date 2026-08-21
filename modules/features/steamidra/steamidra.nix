{ self, inputs, ... }: {

    flake.nixosModules.steamidra = { pkgs, lib, username, ... }: let

        steamidraTags = inputs.nix-crab.inputs.steamidra;

        version = lib.removePrefix "v"
            (builtins.head (builtins.fromJSON (builtins.readFile steamidraTags))).name;

        homeDir = "/home/${username}";
        dataDir = "${homeDir}/.local/share/SteaMidra";

        steamidraLauncher = pkgs.writeShellScriptBin "steamidra" ''
            set -euo pipefail
            app="${dataDir}/SteaMidra.AppImage"

            if [ "$(cat "${dataDir}/.version" 2>/dev/null || true)" != "${version}" ]; then
              ${pkgs.libnotify}/bin/notify-send -a SteaMidra \
                "Downloading SteaMidra ${version}" "About 520 MiB, this takes a while." || true
              tmp=$(mktemp -d)
              trap 'rm -rf "$tmp"' EXIT
              ${pkgs.curl}/bin/curl -fL --progress-bar -o "$tmp/sff.zip" \
                "https://github.com/Midrags/SFF/releases/download/v${version}/SteaMidra-${version}-linux.zip"
              ${pkgs.unzip}/bin/unzip -qo "$tmp/sff.zip" "SteaMidra*.AppImage" "*.png" -d "$tmp"
              mkdir -p "${dataDir}"
              mv "$tmp"/SteaMidra*.AppImage "$app"
              chmod +x "$app"
              mv "$tmp"/*.png "${dataDir}/steamidra.png"
              echo "${version}" > "${dataDir}/.version"
              ${pkgs.libnotify}/bin/notify-send -a SteaMidra "SteaMidra ${version} ready" || true
            fi

            export APPIMAGE="$app"
            export QTWEBENGINE_DISABLE_SANDBOX=1
            exec ${pkgs.appimage-run}/bin/appimage-run "$app" "$@"
        '';

        desktopItem = pkgs.makeDesktopItem {
            name = "steamidra";
            desktopName = "SteaMidra";
            comment = "Steam game setup and manifest tool";
            exec = "${steamidraLauncher}/bin/steamidra";
            icon = "${dataDir}/steamidra.png";
            categories = [ "Utility" ];
            startupNotify = false;
        };

    in {

        environment.systemPackages = [
            pkgs.dotnetCorePackages.runtime_9_0
            steamidraLauncher
        ];

        systemd.tmpfiles.rules = [
            "d ${homeDir}/.local/share/applications 0755 ${username} users -"
            "L+ ${homeDir}/.local/share/applications/steamidra.desktop - ${username} users - ${desktopItem}/share/applications/steamidra.desktop"
        ];

    };

}
