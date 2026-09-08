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

    disko = {
        url = "github:nix-community/disko";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";

    sls-steam = {
        url = "github:AceSLS/SLSsteam";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-crab.url = "github:ItszFinn/nix-crab";

    noctalia = {
    	url = "github:noctalia-dev/noctalia";
        inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };

    noctalia-greeter = {
        url = "github:noctalia-dev/noctalia-greeter";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland"; # follows development branch of hyprland

    hypr-dynamic-cursors = {
        url = "github:VirtCode/hypr-dynamic-cursors";
        inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
    };

    accela.url = "github:ciscosweater/enter-the-wired";

  };

  # import modules/ automatically
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
