{
  inputs = {
    # flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nix-packages";

    nix-packages.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # nix-systems.url = "github:nix-systems/default";

    nixos-packages.url = "github:nixos/nixpkgs/nixos-23.05";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    wsl.url = "github:nix-community/nixos-wsl";
    wsl.inputs.nixpkgs.follows = "nixos-packages";
  };

  outputs = inputs: let
    mkNixosConfiguration = {
      hostName,
      hostPlatform,
      nixosModule,
      userName,
    }: let
      nixosConfiguration = inputs.nixos-packages.lib.nixosSystem;

      packages = import inputs.nixos-packages {
        config.allowUnfree = true;
        localSystem = hostPlatform;
      };

      utilities = packages.lib;
    in
      nixosConfiguration {
        lib = utilities;
        modules = [nixosModule];
        pkgs = packages;

        specialArgs = {
          inherit inputs;
          inherit packages;
          settings = {
            inherit hostName;
            inherit hostPlatform;
            inherit userName;
          };
          inherit utilities;
        };
      };

    mkHomeConfiguration = {
      emailAddress,
      fullName,
      homeModule,
      hostPlatform,
      userName,
    }: let
      homeConfiguration = inputs.home-manager.lib.homeManagerConfiguration;

      packages = import inputs.nix-packages {
        config.allowUnfree = true;
        localSystem = hostPlatform;
      };

      utilities = packages.lib;
    in
      homeConfiguration {
        lib = utilities;
        modules = [homeModule];
        pkgs = packages;

        extraSpecialArgs = {
          inherit inputs;
          inherit packages;
          settings = {
            inherit emailAddress;
            inherit fullName;
            inherit hostPlatform;
            inherit userName;
          };
          inherit utilities;
        };
      };
  in {
    nixosConfigurations = {
      "scott-desktop" = mkNixosConfiguration {
        hostName = "scott-desktop";
        hostPlatform = "x86_64-linux";
        nixosModule = ./hosts/scott-desktop;
        userName = "scott";
      };
    };

    homeConfigurations = {
      "scott@scott-desktop" = mkHomeConfiguration {
        emailAddress = "me@scottwillmoore.au";
        fullName = "Scott Moore";
        homeModule = ./users/scott;
        hostPlatform = "x86_64-linux";
        userName = "scott";
      };
    };
  };
}
