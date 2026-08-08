{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    niri-urayde = { # Niri fork the supports screen tearing
        url = "github:urayde/niri";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    noctalia = {
    	url = "github:noctalia-dev/noctalia";
        inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };

  };

  # import modules/ automatically
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
