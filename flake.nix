{
  description = "Scott's Nix configuration";

  inputs = {
    # Home
    home-manager.url = "github:nix-community/home-manager";
    home-packages.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.inputs.nixpkgs.follows = "home-packages";

    # NixOS
    nixos-packages.url = "github:nixos/nixpkgs/nixos-22.11";
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    nixos-wsl.inputs.nixpkgs.follows = "nixos-packages";
  };

  outputs = inputs @ {
    home-manager,
    home-packages,
    nixos-packages,
    nixos-wsl,
    ...
  }: let
    # Home
    mkHomeConfiguration = {
      homeModule,
      hostPlatform,
      userName,
    }: let
      homeConfiguration = home-manager.lib.homeManagerConfiguration;
      packages = home-packages.legacyPackages.${hostPlatform};
    in
      homeConfiguration {
        extraSpecialArgs = {
          inherit inputs;
          inherit packages;
          settings = {
            inherit hostPlatform;
            inherit userName;
          };
        };
        modules = [homeModule];
        pkgs = packages;
      };

    # NixOS
    mkNixosConfiguration = {
      hostName,
      hostPlatform,
      nixosModule,
      userName,
    }: let
      nixosConfiguration = nixos-packages.lib.nixosSystem;
      packages = nixos-packages.legacyPackages.${hostPlatform};
    in
      nixosConfiguration {
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
        };
      };
  in {
    # Home
    homeConfigurations = {
      "scott@scott-desktop" = mkHomeConfiguration {
        homeModule = ./home.nix;
        hostPlatform = "x86_64-linux";
        userName = "scott";
      };
    };

    # NixOS
    nixosConfigurations = {
      "scott-desktop" = mkNixosConfiguration {
        hostName = "scott-desktop";
        hostPlatform = "x86_64-linux";
        nixosModule = ./configuration.nix;
        userName = "scott";
      };
    };
  };
}
