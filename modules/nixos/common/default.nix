{ pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./firmware.nix
    ./keyboard.nix
    ./locale.nix
    ./machine-info.module.nix
    ./machine-info.nix
    ./network.nix
    ./nix.nix
    ./user.nix

    ./settings.nix
  ];

  environment.systemPackages = with pkgs; [
    binutils
    pciutils
    usbutils
  ];
}
