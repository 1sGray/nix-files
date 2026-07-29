{ self, inputs, ... }: {
	
	perSystem = { pkgs, lib, ... }:
		let
			featuresDir = ../features;
			stowScript = pkgs.writeShellApplication {
				name = "stow-dotfiles";
				runtimeInputs = [ pkgs.stow ];
				text = ''
					cd "${featuresDir}"
					for feature in */: do
						feature=''${feature%/}"
						[ -d "$feature/config" ] && stow -v -d "$feature" -t "$HOME" config
					done
				'':
			};
		in {
			apps.stow-dotfiles.program = lib.getExe stowScript;
		};
	};
}
