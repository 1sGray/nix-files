{ self, inputs, ... }: {
	
	flake.nixosModules.noctaliaGreeter = { pkgs, lib, ... }: {

        programs.noctalia-greeter = {
            enable = true;
            # Optional: extra flags after `--` on noctalia-greeter-session
            greeter-args = "";

            # Full declarative greeter.toml (overwritten each activation). See examples/greeter.toml.
            settings = {
                cursor = {
                    theme = "Bibata-Modern-Ice";
                    size = 24;
                    path = "${pkgs.bibata-cursors}/share/icons";
                };
            };
        };

    };

	# perSystem = { pkg , lib, ... }: {};
}
