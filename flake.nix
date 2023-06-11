{
  inputs = {
    nixos-packages.url = "github:nixos/nixpkgs/nixos-23.05";
    unstable-packages.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-utilities.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    wsl.url = "github:nix-community/nixos-wsl";

    home-manager.inputs.nixpkgs.follows = "unstable-packages";
    wsl.inputs.flake-utils.follows = "flake-utilities";
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
        system = hostPlatform;
      };
    in
      nixosConfiguration {
        modules = [
          nixosModule
        ];
        pkgs = packages;
        specialArgs = {
          inherit inputs;
          inherit packages;
          settings = {
            inherit hostName;
            inherit hostPlatform;
            inherit userName;
          };
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

      packages = import inputs.unstable-packages {
        config.allowUnfree = true;
        system = hostPlatform;
      };
    in
      homeConfiguration {
        extraSpecialArgs = {
          inherit inputs;
          inherit packages;
          settings = {
            inherit emailAddress;
            inherit fullName;
            inherit hostPlatform;
            inherit userName;
          };
        };
        modules = [
          homeModule
        ];
        pkgs = packages;
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
