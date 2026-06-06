{ pkgs, ... }:
{
  imports = [
    ./gnome.nix
  ];

  # fonts.enableDefaultPackages = false;
  fonts.packages = with pkgs; [
    # Monospace
    fira-code
    iosevka
    jetbrains-mono
    lilex
    nerd-fonts.symbols-only

    # Sans-serif
    inter
    noto-fonts
    noto-fonts-color-emoji
    roboto
  ];

  boot.plymouth.enable = true;
  boot.plymouth.theme = "spinner";

  services.flatpak.enable = true;
}
