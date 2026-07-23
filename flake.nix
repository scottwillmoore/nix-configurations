{
  description = "Scott's Nix configurations";

  inputs = {
    firefox-gnome-theme.flake = false;
    firefox-gnome-theme.url = "github:rafaelmardojai/firefox-gnome-theme";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";

    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/v1.1.0";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./modules/flake
      ];

      settings = {
        # authorizedKeys = [
        #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHpwam0hQH7uJUC6DfeApxxHQ07t47SzSVT/kHmOgDkT"
        # ];
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
