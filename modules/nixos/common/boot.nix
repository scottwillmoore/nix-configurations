{ inputs, pkgs, ... }:
{
  imports = [
    inputs.lanzaboote.nixosModules.default
  ];

  # Loader

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  # Secure Boot

  boot.lanzaboote.enable = true;
  boot.lanzaboote = {
    pkiBundle = "/var/lib/sbctl";
  };

  environment.systemPackages = [
    pkgs.sbctl
  ];
}
