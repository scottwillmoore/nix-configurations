{ inputs, pkgs, ... }:
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "usbhid"
    "xhci_pci"
  ];

  # Nvidia
  # boot.initrd.kernelModules = [
  #   "nvidia"
  #   "nvidia_modeset"
  #   "nvidia_drm"
  # ];

  boot.initrd.systemd.enable = true;

  boot.lanzaboote.enable = true;
  boot.lanzaboote.configurationLimit = 8;
  boot.lanzaboote.pkiBundle = "/etc/secureboot";
  boot.lanzaboote.settings.console-mode = "max";
  boot.lanzaboote.settings.timeout = 0;

  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth.enable = true;
  boot.plymouth.theme = "spinner";

  environment.systemPackages = with pkgs; [ sbctl ];
}
