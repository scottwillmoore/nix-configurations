{ pkgs, ... }:
{
  system.stateVersion = "24.05";

  imports = [
    ./boot.nix
    ./desktop.nix
    ./file-system.nix
    ./flatpak.nix
    ./font.nix
    ./hardware.nix
    ./keyboard.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./user.nix
  ];

  documentation.doc.enable = false;
  documentation.info.enable = false;

  nixpkgs.config.allowUnfree = true;

  # Packages

  environment.systemPackages = with pkgs; [
    binutils
    pciutils
    usbutils
  ];

  # Programs

  programs.fish.enable = true;

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;
  };

  programs.nix-ld.enable = true;
}
