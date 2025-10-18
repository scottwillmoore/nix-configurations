{ pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./firmware.nix
    ./keyboard.nix
    ./locale.nix
    ./network.nix
    ./nix.nix

    ./settings.nix
  ];

  environment.systemPackages = with pkgs; [
    binutils
    pciutils
    usbutils
  ];
}
