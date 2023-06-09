{
  inputs = {
    nixos-packages.url = "github:nixos/nixpkgs/nixos-23.05";

    nixos-wsl.url = "github:nix-community/nixos-wsl";

    nixos-wsl.inputs.nixpkgs.follows = "nixos-packages";

    home-packages.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";

    home-manager.inputs.nixpkgs.follows = "home-packages";
  };

  outputs = inputs @ {
    nixos-packages,
    home-packages,
    home-manager,
    ...
  }: let
    mkNixosConfiguration = {
      hostName,
      hostPlatform,
      nixosModule,
      userName,
    }: let
      nixosConfiguration = nixos-packages.lib.nixosSystem;
      packages = import nixos-packages {
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
      homeConfiguration = home-manager.lib.homeManagerConfiguration;
      packages = import home-packages {
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
