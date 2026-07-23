{ pkgs, ... }:
{
  imports = [
    ./gnome.nix
    ./user.nix
  ];

  fonts.packages = with pkgs; [
    # Monospace
    fira-code
    iosevka
    jetbrains-mono
    nerd-fonts.symbols-only

    # Sans-serif
    inter
    noto-fonts
    noto-fonts-color-emoji
    roboto
  ];

  boot.plymouth.enable = true;

  services.printing.enable = true;

  services.udev.extraRules = ''
    # Nuphy Air 75 V3
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="19f5", ATTRS{idProduct}=="1028", MODE="0666"
    # Nuphy Air 75 V3 Dongle
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="19f5", ATTRS{idProduct}=="2620", MODE="0666"
    # Nuphy Air 75 V3 Upgrader
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="19f5", ATTRS{idProduct}=="0722", MODE="0666"
  '';
}
