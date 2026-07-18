{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.flakeModules
    inputs.flake-parts.flakeModules.partitions

    inputs.home-manager.flakeModules.default

    ./imports.nix
    ./outputs.nix
    ./packages.nix
    ./settings.nix
  ];
}
