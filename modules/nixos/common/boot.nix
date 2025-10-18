{ inputs, pkgs, ... }:
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  boot.initrd.systemd.enable = true;

  boot.lanzaboote.enable = true;
  boot.lanzaboote.pkiBundle = "/var/lib/sbctl";

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
