{ ... }: {
	
	flake.nixosModules.fzf = { pkgs, ... }: {
        environment.systemPackages = [
            pkgs.fzf
        ];

    };

}

