{ self, inputs, ... }: {

	flake.nixosModules.hyprland = { pkgs, lib, username, ... }: let
		hyprDir = "/home/${username}/.config/hypr";
		hyprConfigs = ./configs/.config/hypr;
		mkLink = name: "L+ ${hyprDir}/${name} - ${username} users - ${hyprConfigs}/${name}";
	in {

		# Uses Hyprland's Lua config (hyprland.lua), shipped in Hyprland 0.55+.
		# If your pinned nixpkgs' pkgs.hyprland predates that, bump nixpkgs or
		# add the hyprwm/Hyprland flake input and set programs.hyprland.package.
		programs.hyprland.enable = true;

        # Stable, colon-free device symlinks for AQ_DRM_DEVICES — card0/card1
		# numbering isn't guaranteed stable across boots, and by-path names
		# contain colons that collide with AQ_DRM_DEVICES's ":" separator.
		services.udev.extraRules = ''
			SUBSYSTEM=="drm", KERNEL=="card[0-9]", ATTRS{vendor}=="0x8086", SYMLINK+="dri/card-intel"
			SUBSYSTEM=="drm", KERNEL=="card[0-9]", ATTRS{vendor}=="0x10de", SYMLINK+="dri/card-nvidia"
		'';

		systemd.tmpfiles.rules = [
			"d ${hyprDir} 0755 ${username} users -"
		] ++ map mkLink [
			"hyprland.lua"
			"monitors.lua"
			"graphics.lua"
			"inputs.lua"
			"look.lua"
			"window-rules.lua"
			"keybinds.lua"
			"noctalia.lua"
		];
	};
}
