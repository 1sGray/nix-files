{ self, inputs, ... }: {

    flake.nixosModules.generalConfiguration = { pkgs, config, username, hostname, ... }: {
#=====================================================================================================
# Modules
#=====================================================================================================
        imports = with self.nixosModules; [
            machineHardware
            niri
            noctalia
            zram
            ananicy
            scx


            # Cli Tools ==============================================================================
            starship
            fastfetch
            fzf

            # TUI Apps ===============================================================================
            zellij
            kitty
            neovim
            yazi
            zsh

            # GUI Apps ===============================================================================

            # Services ===============================================================================
            syncthing

            # Steam Stuff ============================================================================
            # steam
            gamescope
            mangohud
            nixCrabSteam

        ];

#=====================================================================================================
# Users
#=====================================================================================================

		# Define a user account. Don't forget to set a password with ‘passwd’.

		users.users."gray" = {
			isNormalUser = true;
			description = "Gray";
			extraGroups = [ "networkmanager" "wheel" ];
			# packages = with pkgs; [];
			shell = self.packages.${pkgs.stdenv.hostPlatform.system}.myZsh;
		};


#=====================================================================================================
# Global Packages
#=====================================================================================================

		# List packages installed in system profile. To search, run:
		# $ nix search wget

		environment.systemPackages = with pkgs; [

            # GUI Apps ===============================================================================
            obsidian
            discord
			brave

            # Services ===============================================================================
            keepassxc
            udiskie # udisks2 frontend
			xwayland-satellite
            
            # TUI Apps ===============================================================================
            bottom

            # Cli Tools ==============================================================================
			wget
			git

            ffmpeg
            poppler
            resvg
            imagemagick

            p7zip-rar
            wev
            jq

            # The enhancements
            eza # better ls
            fd # better find
			ripgrep # better grep
            bat # better cat
            zoxide # better cd



            # LSPs ===================================================================================
            lua-language-server
            rust-analyzer
            nixd

		];

		
		nixpkgs.config.allowUnfree = true; # Allow unfree packages

#=====================================================================================================
# Bootloader
#=====================================================================================================

		# boot.loader.systemd-boot.enable = true;
		boot.loader.efi.canTouchEfiVariables = true;
		boot.loader.grub = {
			enable = true;
			efiSupport = true;
			device = "nodev";
			useOSProber = true;
            configurationLimit = 2; # This limits grub to only two kernel+initrd file generation, CachyOS kernels are CHONKY

		};

#=====================================================================================================
# Connetions
#=====================================================================================================

		networking = {
			hostName = "p53"; # Define your hostname.
			wireless.enable = true;  # Enables wireless support via wpa_supplicant.
			networkmanager.enable = true; # Enable networking
		};

		hardware.bluetooth.enable = true;

#=====================================================================================================
# Kernel
#=====================================================================================================
		
		# boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.

		# Using The CachyOS Linux Kernel
		nixpkgs.overlays = [
			inputs.nix-cachyos-kernel.overlays.pinned
		];
		# boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore; # Use latest kernel with BORE scheduler.
		boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3; # Use latest kernel with BORE scheduler, v3 Processor optimization level for Coffee-Lake CPU, and Link-Time optimization.

        nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
        nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

#=====================================================================================================
# Grapics
#=====================================================================================================
		boot.initrd.kernelModules = [ 
			"i915" # early KMS font fix

			#          # The following loads nvidia modules, if dGPU is used only when neccissary then keep commented
			#
			# "nvidia"
			# "nvidia_modeset"
			# "nvidia_drm"
			# "ntsync"
		];

        # Xorg drivers (needed even w/o xorg & on Wayland): "modesetting" handles the Intel iGPU, "nvidia" is required for the dGPU
        services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

        hardware.graphics = {
            enable = true; # OpenGL/Vulkan userspace support

            extraPackages = with pkgs; [
                intel-media-driver # VA-API for the iGPU — LIBVA_DRIVER_NAME=iHD, works with Brave/Chromium
            ];
        };

        hardware.nvidia = {

           open = false; 
           package = config.boot.kernelPackages.nvidiaPackages.stable; # properietary kernel module - most mature/well tested path for Turing class cards like T1000
           nvidiaSettings = true;
           modesetting.enable = true;   # required for Wayland

           prime = {

               offload = {
                   enable = true; 
                   enableOffloadCmd = true; # gives you a `nvidia-offload` wrapper command
               };

               intelBusId = "PCI:0@0:2:0";
               nvidiaBusId = "PCI:1@0:0:0";

           };

           powerManagement.enable = true;
           powerManagement.finegrained = true; # This lets the T1000 fully suspend (RTD3) when nothing's using it.
           videoAcceleration = true;

        };

#=====================================================================================================
# Wayland
#=====================================================================================================

		# environment.systemPackages = pkgs.;

		programs.xwayland.enable = true;

#=====================================================================================================
# Inputs
#=====================================================================================================

        # services.libinput = {
        #     enable = true;
        #      mouse = {
        #          accelProfile = "flat"; # Disables acceleration for raw input
        #          # Note: Direct speed adjustment options for mice are limited in libinput;
        #          # some users resort to xinput or extraConfig for precise speed control.
        #      };
        # };

#=====================================================================================================
# Power
#=====================================================================================================

		services.power-profiles-daemon.enable = true;
		services.upower.enable = true;

#=====================================================================================================
# Disks & Storage
#=====================================================================================================

        boot.supportedFilesystems = [
            "exfat"
            "ntfs"
            "btrfs"
        ];

        services.udisks2.enable = true;
        services.gvfs.enable = true;
        services.devmon.enable = true;


#=====================================================================================================
# Fonts
#=====================================================================================================

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

#=====================================================================================================
# TTY
#=====================================================================================================
# {{{
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
# }}}
#=====================================================================================================
# Locale, Language, and Timezone
#=====================================================================================================

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

#======================================================================================================
# Misc
#======================================================================================================

		nix.settings.experimental-features = [ "nix-command" "flakes" ];

		system.stateVersion = "26.05"; # Did you read the comment?



    };

}
