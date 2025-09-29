{ outputs, pkgs, ... }:
{
  imports = [
    outputs.nixosModules.common

    ./boot.nix
    ./desktop.nix
    ./file-system.nix
    ./flatpak.nix
    ./hardware.nix
    ./user.nix
  ];

  settings = {
    computerName = "Scott's Desktop";
    hostName = "scott-desktop";
    hostPlatform = "x86_64-linux";
  };

  documentation.doc.enable = false;
  documentation.info.enable = false;

  # Programs

  programs.fish.enable = true;

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;
  };

  programs.nix-ld.enable = true;
}
