{ pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./firmware.nix
    ./keyboard.nix
    ./locale.nix
    ./network.nix

    ./settings.nix
    ./nix.nix
    ./nixpkgs.nix
  ];

  environment.systemPackages = with pkgs; [
    binutils
    pciutils
    usbutils
  ];
}
