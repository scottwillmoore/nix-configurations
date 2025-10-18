{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.flakeModules
    inputs.flake-parts.flakeModules.partitions

    inputs.home-manager.flakeModules.default

    inputs.nixvim.flakeModules.default

    ./aliases.nix
    ./imports.nix
    ./packages.nix
    ./settings.nix
    ./utilities.nix
  ];
}
