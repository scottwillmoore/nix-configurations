{ inputs, ... }:
{
  imports = [
    inputs.nixvim.flakeModules.default

    ./aliases.nix
    ./imports.nix
    ./settings.nix
    ./utilities.nix
  ];
}
