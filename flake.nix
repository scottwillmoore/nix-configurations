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

    ## NixOS

    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    inputs:
    let
      lib = inputs.nixpkgs.lib.extend (self: super: import ./lib.nix super);
    in
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

      flake = {
        inherit lib;
      };
    };
}
