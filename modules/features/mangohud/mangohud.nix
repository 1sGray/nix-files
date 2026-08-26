{ self, inputs, ... }: {

	flake.nixosModules.mangohud = { pkgs, username, ... }: {
		environment.systemPackages = [ pkgs.mangohud ];

     systemd.tmpfiles.rules = [
            # Create the SLSsteam config directory if missing
            "d /home/${username}/.config/MangoHud 0755 ${username} users -"

            # Symlink your config.yaml ONLY if the destination does NOT exist (L vs L+)
            "L /home/${username}/.config/MangoHud/MangoHud.conf - - - - ${./configs/.config/MangoHud/MangoHud.conf}"
        ];

	};
	# perSystem = { pkg , lib, ... }: {};
}
