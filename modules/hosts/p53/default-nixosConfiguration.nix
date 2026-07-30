{ self, inputs, ... }: {

	flake.nixosConfigurations.p53 = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			self.nixosModules.machineConfiguration
		];
	};

  flake.nixosModules.machineConfiguration = { pkgs, lib, ... }: {
    imports = [
        self.nixosModules.machineHardware
        self.nixosModules.niri
        self.nixosModules.neovim
        # self.nixosModules.myGrub
        self.nixosModules.p53Graphics
    ];

		# Bootloader.
		# boot.loader.systemd-boot.enable = true;
		boot.loader.efi.canTouchEfiVariables = true;
		boot.loader.grub = {
			enable = true;
			efiSupport = true;
			device = "nodev";
			useOSProber = true;

		};

		fonts = {
			enableDefaultPackages = true;

			packages = with pkgs; [
				nerd-fonts.fira-code
				nerd-fonts.jetbrains-mono
				noto-fonts
				noto-fonts-cjk-sans
				noto-fonts-color-emoji
				# liberaton_ttf
			];

			fontconfig.defaultFonts = {
				monospace = [ "FiraCode Nerd Font" ];
				sansSerif = [ "Noto Sans" ];
				serif = [ "Noto Serif" ];
			};

		};

		console = {

			colors = [
				# Solrized Dark
				# "002b36"
				# "dc322f"
				# "859900"
				# "b58900"
				# "268bd2"
				# "d33682"
				# "2aa198"
				# "eee8d5"
				# "002b36"
				# "cb4b16"
				# "586e75"
				# "657b83"
				# "839496"
				# "6c71c4"
				# "93a1a1"
				# "fdf6e3"

				#Gruvbox Hard Dark
				"1d2021"  # black — bg0_h (hard background)
				"cc241d"  # red
				"98971a"  # green
				"d79921"  # yellow
				"458588"  # blue
				"b16286"  # magenta — purple
				"689d6a"  # cyan — aqua
				"a89984"  # white — fg4 (gray)
				"928374"  # bright black — gray
				"fb4934"  # bright red
				"b8bb26"  # bright green
				"fabd2f"  # bright yellow
				"83a598"  # bright blue
				"d3869b"  # bright magenta — purple
				"8ec07c"  # bright cyan — aqua
				"ebdbb2"  # bright white — fg1 (foreground)
			];

			packages = [
				pkgs.terminus_font
			];

			# font = "${pkgs.terminus_font}/share/consolefonts/ter-u20b.psf.gz";
      font = "ter-u20b";
			earlySetup = true;
		};

		# Use latest kernel.
		boot.kernelPackages = pkgs.linuxPackages_latest;

		networking.hostName = "p53"; # Define your hostname.
		networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

		# Enable networking
		networking.networkmanager.enable = true;

		# Set your time zone.
		time.timeZone = "America/Chicago";

		# Select internationalisation properties.
		i18n.defaultLocale = "en_US.UTF-8";

		i18n.extraLocaleSettings = {
		  LC_ADDRESS = "en_GB.UTF-8";
		  LC_IDENTIFICATION = "en_GB.UTF-8";
		  LC_MEASUREMENT = "en_GB.UTF-8";
		  LC_MONETARY = "en_GB.UTF-8";
		  LC_NAME = "en_GB.UTF-8";
		  LC_NUMERIC = "en_GB.UTF-8";
		  LC_PAPER = "en_GB.UTF-8";
		  LC_TELEPHONE = "en_GB.UTF-8";
		  LC_TIME = "en_GB.UTF-8";
		};

		# Configure keymap in X11
		# services.xserver.xkb = {
		#   layout = "us";
		#   variant = "";
		# };

		# Define a user account. Don't forget to set a password with ‘passwd’.
		users.users."gray" = {
		  isNormalUser = true;
		  description = "Gray";
		  extraGroups = [ "networkmanager" "wheel" ];
		  packages = with pkgs; [];
		};

		# Allow unfree packages
		nixpkgs.config.allowUnfree = true;

		# List packages installed in system profile. To search, run:
		# $ nix search wget
		environment.systemPackages = with pkgs; [
		  # neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
		  wget
		  git
		  brave
		];
		
		nix.settings.experimental-features = [ "nix-command" "flakes" ];

		system.stateVersion = "26.05"; # Did you read the comment?
	};
}
