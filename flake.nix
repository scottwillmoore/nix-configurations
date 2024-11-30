{
  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";

    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    let
      lib = inputs.nixpkgs.lib.extend (self: super: import ./lib.nix super);
    in
    {
      inherit lib;

      nixosConfigurations."scott-desktop" = inputs.nixpkgs.lib.nixosSystem {
        modules = [ ./scott-desktop ];

        specialArgs = {
          inherit inputs;
          inherit lib;

          settings = {
            # Host
            computerName = "Scott's Desktop";
            hostName = "scott-desktop";
            hostPlatform = "x86_64-linux";

            # User
            emailAddress = "me@scottwillmoore.au";
            fullName = "Scott Moore";
            hashedPassword = "$y$j9T$6K2y3iI1hLG.Ei4NAw.tB0$Zr8cPkLDf7pdmxXkzflwcgFAuvB/6qm6Mt9L4xC6EYC";
            userName = "scott";
          };
        };
      };
    };
}
