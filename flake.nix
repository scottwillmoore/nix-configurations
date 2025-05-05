{
  inputs = {
    # Flakes

    flake-parts.url = "github:hercules-ci/flake-parts";

    # Packages

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Systems

    ## Home Manager

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";

    firefox-gnome-theme.flake = false;
    firefox-gnome-theme.url = "github:rafaelmardojai/firefox-gnome-theme";

    ## NixOS

    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    ## Vim

    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./modules/flake
      ];

      settings = {
        emailAddress = "me@scottwillmoore.au";
        fullName = "Scott Moore";
        userName = "scott";
      };

      systems = [
        "x86_64-linux"
      ];
    };
}
