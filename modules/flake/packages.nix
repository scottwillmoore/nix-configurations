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
        { system, ... }:
        {
          _module.args.packages = outputs.nixPackages;

          nixPackages = import inputs.nixpkgs {
            inherit system;

            config = {
              allowUnfree = true;
            };
          };
        };
    }
  ];
}
