{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    noctalia = {
    	url = "github:noctalia-dev/noctalia";
    };

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  # import modules/ automatically
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
