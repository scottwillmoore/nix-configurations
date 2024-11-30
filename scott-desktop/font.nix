{ pkgs, ... }:
{
  fonts.enableDefaultPackages = false;
  fonts.packages = [
    pkgs.iosevka
    pkgs.inter
    (pkgs.nerdfonts.override {
      fonts = [
        "Iosevka"
        "NerdFontsSymbolsOnly"
      ];
    })
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
    pkgs.roboto
  ];
}
