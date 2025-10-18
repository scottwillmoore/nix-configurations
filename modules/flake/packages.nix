{
  lib,
  flake-parts-lib,

  inputs,
  outputs,

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

    {
      perSystem =
        { inputs', ... }:
        {
          _module.args.packages = outputs.nixPackages;

          nixPackages = inputs'.nixpkgs.legacyPackages;
        };
    }
  ];
}
