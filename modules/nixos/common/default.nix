{ pkgs, ... }:
{
  system.stateVersion = "22.05";

  imports = [
    ./aliases.nix
    ./settings.nix

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
