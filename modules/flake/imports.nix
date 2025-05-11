{
  self,
  inputs,
  utilities,
  ...
}:
let
  getImportPaths =
    dirPath:
    if builtins.pathExists dirPath then
      utilities.pipe dirPath [
        builtins.readDir
        (utilities.mapAttrsToList (
          entryName: entryType:
          let
            importPath = "${dirPath}/${entryName}";
          in
          if entryType == "regular" && utilities.hasSuffix ".nix" entryName then
            utilities.nameValuePair (utilities.removeSuffix ".nix" entryName) importPath
          else if entryType == "directory" && builtins.pathExists "${importPath}/default.nix" then
            utilities.nameValuePair entryName importPath
          else
            null
        ))
        (utilities.filter (element: element != null))
        utilities.listToAttrs
      ]
    else
      { };

  mapImportPaths = dirPath: f: utilities.mapAttrs f (getImportPaths dirPath);

  commonArgs = {
    inherit inputs;
    inherit utilities;
  };
in
{
  outputs = {
    flakeModules = getImportPaths "${self}/modules/flake";

    homeModules = getImportPaths "${self}/modules/home";

    nixosConfigurations = mapImportPaths "${self}/configurations/nixos" (
      name: path:
      inputs.nixpkgs.lib.nixosSystem {
        modules = [
          path
        ];

        specialArgs = commonArgs // {
          inherit name;

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
      }
    );

    nixosModules = getImportPaths "${self}/modules/nixos";

    nixvimModules = getImportPaths "${self}/modules/nixvim";
  };

  perSystem =
    # Module arguments are only evaluated in a strict manner when deconstructed
    # in order to prevent infinite recursion. Hence important attributes must be
    # deconstructed by this function for them to be used by these imports!
    # https://github.com/NixOS/nixpkgs/blob/ec1aa8f0413f1ec74ec1a11a325983d0000183e7/lib/modules.nix#L537-L561
    args@{ pkgs, system, ... }:
    {
      devShells = mapImportPaths "${self}/shells" (
        name: path:
        import path (
          commonArgs
          // args
          // {
            inherit name;
          }
        )
      );

      nixvimConfigurations = mapImportPaths "${self}/configurations/nixvim" (
        name: path:
        inputs.nixvim.lib.evalNixvim {
          modules = [
            { nixpkgs.pkgs = pkgs; }
            path
          ];

          extraSpecialArgs = commonArgs // {
            inherit name;
          };
        }
      );
    };
}
