{ pkgs, ... }:
{
  imports = [
    ./gnome.nix
  ];

  # fonts.enableDefaultPackages = false;
  fonts.packages = with pkgs; [
    inter
    iosevka
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
    roboto
  ];

  boot.plymouth.enable = true;
  boot.plymouth.theme = "spinner";
}
