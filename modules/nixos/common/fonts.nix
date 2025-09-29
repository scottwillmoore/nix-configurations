{ pkgs, ... }:
{
  # fonts.enableDefaultPackages = false;
  fonts.packages = [
    pkgs.inter
    pkgs.iosevka
    pkgs.nerd-fonts.symbols-only
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
    pkgs.roboto
  ];
}
