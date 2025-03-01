{
  inputs,
  self,
  ...
}:
let
  # TODO
  lib = inputs.self.lib;

  readImportPaths =
    dirPath:
    if builtins.pathExists dirPath then
      lib.pipe dirPath [
        builtins.readDir
        (lib.mapAttrsToList (
          entryName: entryType:
          let
            importPath = "${dirPath}/${entryName}";
          in
          if entryType == "regular" && lib.hasSuffix ".nix" entryName then
            lib.nameValuePair (lib.removeSuffix ".nix" entryName) importPath
          else if entryType == "directory" && builtins.pathExists "${importPath}/default.nix" then
            lib.nameValuePair entryName importPath
          else
            null
        ))
        (lib.filter (element: element != null))
        lib.listToAttrs
      ]
    else
      { };

  mapImportPaths = f: dirPath: lib.mapAttrs f (readImportPaths dirPath);

  mkNixosConfiguration =
    name: path:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        path
      ];
      specialArgs = {
        inherit inputs;
        inherit lib;

        # TODO
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
in
{
  # https://determinate.systems/posts/flake-schemas/
  flake = {
    flakeModules = readImportPaths "${self}/modules/flake";

    homeModules = readImportPaths "${self}/modules/home";

    nixosConfigurations = mapImportPaths mkNixosConfiguration "${self}/configurations/nixos";
    nixosModules = readImportPaths "${self}/modules/nixos";

    # TODO
    # darwinConfigurations = readImportPaths "${self}/configurations/darwin";
    # darwinModules = readImportPaths "${self}/modules/darwin";
    # overlays = readImportPaths "${self}/overlays";
    # templates = readImportPaths "${self}/templates";
  };

  perSystem =
    # https://github.com/NixOS/nixpkgs/blob/ec1aa8f0413f1ec74ec1a11a325983d0000183e7/lib/modules.nix#L537-L561
    args@{ pkgs, ... }:
    {
      devShells = mapImportPaths (
        name: path:
        import path (
          args
          // {
            inherit name;
          }
        )
      ) "${self}/shells";

      # TODO
      # apps = readImportPaths "${self}/apps";
      # packages = readImportPaths "${self}/packages";
      # packages.homeConfigurations = readImportPaths "${self}/configurations/home";
    };
}
