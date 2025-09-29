{ pkgs, ... }:
{
  system.stateVersion = "22.05";

  imports = [
    ./settings.nix

    ./fonts.nix

    ./keyboard.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./nixpkgs.nix
  ];

  environment.systemPackages = with pkgs; [
    binutils
    pciutils
    usbutils
  ];
}
