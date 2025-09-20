{
  description = "Scott's Nix configurations";

  inputs = {
    firefox-gnome-theme.flake = false;
    firefox-gnome-theme.url = "github:rafaelmardojai/firefox-gnome-theme";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";

    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
        hashedPassword = "$y$j9T$6K2y3iI1hLG.Ei4NAw.tB0$Zr8cPkLDf7pdmxXkzflwcgFAuvB/6qm6Mt9L4xC6EYC";
        userName = "scott";
      };

      systems = [
        "x86_64-linux"
      ];
    };
}
