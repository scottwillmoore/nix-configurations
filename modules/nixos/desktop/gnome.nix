{ pkgs, ... }:
{
  environment.gnome.excludePackages = [
    # These excluded packages are derived from the NixOS module for Gnome:
    # https://github.com/nixos/nixpkgs/blob/master/nixos/modules/services/desktop-managers/gnome.nix

    # Core shell utilities:
    pkgs.gnome-shell-extensions
    pkgs.gnome-tour # Tour
    pkgs.gnome-user-docs

    # Core utilities:
    pkgs.epiphany # Web
    pkgs.snapshot # Camera
    pkgs.yelp # Help
  ];

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  services.flatpak.enable = true;

  services.gnome.gcr-ssh-agent.enable = false;

  services.xserver.enable = true;
  services.xserver.excludePackages = [
    # These excluded packages are derived from the Nixos module for XServer:
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/xserver.nix

    pkgs.xterm
  ];
}
