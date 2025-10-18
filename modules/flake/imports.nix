{
  lib,

  self,

  inputs,
  outputs,
  settings,

  ...
}:
let
  getImportPaths =
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

  mapImportPaths = dirPath: f: lib.mapAttrs f (getImportPaths dirPath);

  commonArgs = {
    inherit inputs;
    inherit outputs;
    # inherit settings;
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
          {
            inherit settings;
          }

          (
            { outputs, settings, ... }:
            {
              nixpkgs.pkgs = outputs.nixPackages.${settings.hostPlatform};
            }
          )

          path
        ];

        specialArgs = commonArgs // {
          inherit name;
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
    args@{ packages, system, ... }:
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
            {
              nixpkgs.pkgs = packages;
            }

            path

          ];

          extraSpecialArgs = commonArgs // {
            inherit name;
          };
        }
      );
    };
}
