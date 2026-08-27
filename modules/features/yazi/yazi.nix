# modules/features/yazi/yazi.nix
{ self, inputs, ... }: {

	flake.nixosModules.yazi = { pkgs, lib, username, ... }: let

		configDir = ./configs/.config/yazi;
		homeDir = "/home/${username}";
		yaziConfigDir = "${homeDir}/.config/yazi";

		# nixpkgs-packaged plugins to symlink in. Add/remove entries here.
		plugins = with pkgs.yaziPlugins; {
			full-border = full-border;
			# smart-enter = smart-enter;
			# git = git;
		};

		pluginLinkRules = lib.mapAttrsToList (name: drv:
			"L+ ${yaziConfigDir}/plugins/${name}.yazi - ${username} users - ${drv}"
		) plugins;

	in {
		environment.systemPackages = [ pkgs.yazi ];

		systemd.tmpfiles.rules = [
			"d ${yaziConfigDir} 0755 ${username} users -"
			"d ${yaziConfigDir}/plugins 0755 ${username} users -"

			# Static, Nix-managed files
			"L+ ${yaziConfigDir}/yazi.toml - ${username} users - ${configDir}/yazi.toml"
			"L+ ${yaziConfigDir}/keymap.toml - ${username} users - ${configDir}/keymap.toml"
			"L+ ${yaziConfigDir}/init.lua - ${username} users - ${configDir}/init.lua"

			# Deliberately NOT managing theme.toml here — noctalia/matugen
			# owns that file directly and writes it live.
		] ++ pluginLinkRules;
	};

}
