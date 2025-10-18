{
  lib,
  flake-parts-lib,

  self,

  inputs,

  ...
}:
let
  inherit (lib)
    mkOption
    types
    ;
  inherit (flake-parts-lib)
    mkTransposedPerSystemModule
    ;
in
{
  imports = [
    (mkTransposedPerSystemModule {
      name = "nixPackages";
      option = mkOption {
        type = types.lazyAttrsOf types.raw;
        default = { };
      };
      file = ./packages.nix;
    })

    ({
      perSystem =
        { inputs', ... }:
        {
          config = {
            _module.args.packages = self.outputs.nixPackages;

            nixPackages = inputs'.nixpkgs.legacyPackages;
          };
        };
    })
  ];
}
