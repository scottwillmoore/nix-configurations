{ pkgs, ... }:
{
  environment.gnome.excludePackages = [
    # These excluded packages are derived from the NixOS module for Gnome:
    # https://github.com/nixos/nixpkgs/blob/master/nixos/modules/services/x11/desktop-managers/gnome.nix

    # Core shell utilities:

    # pkgs.adwaita-icon-theme
    # pkgs.gnome-backgrounds
    # pkgs.gnome-bluetooth
    # pkgs.gnome-color-manager
    # pkgs.gnome-control-center
    pkgs.gnome-shell-extensions
    pkgs.gnome-tour
    pkgs.gnome-user-docs
    # pkgs.glib
    # pkgs.gnome-menus
    # pkgs.gtk3.out
    # pkgs.xdg-user-dirs

    # Core utilities:

    pkgs.baobab # Disk Usage Analyzer
    pkgs.epiphany # Web
    # pkgs.evince # Document Viewer
    pkgs.file-roller
    pkgs.geary
    # pkgs.gnome-calculator
    pkgs.gnome-calendar
    # pkgs.gnome-characters
    # pkgs.gnome-clocks
    pkgs.gnome-connections
    # pkgs.gnome-console
    pkgs.gnome-contacts
    # pkgs.gnome-disk-utility # Disks
    # pkgs.gnome-font-viewer # Fonts
    pkgs.gnome-logs
    pkgs.gnome-maps
    pkgs.gnome-music
    # pkgs.gnome-software
    # pkgs.gnome-system-monitor
    pkgs.gnome-text-editor
    pkgs.gnome-weather
    # pkgs.loupe # Image viewer
    # pkgs.nautilus # Files
    # pkgs.seahorse # Passwords and Keys
    pkgs.simple-scan # Document Scanner
    pkgs.snapshot # Camera
    # pkgs.sushi # File Previewer
    pkgs.totem # Videos
    pkgs.yelp # Help
  ];

  environment.systemPackages = [
    pkgs.dconf-editor
    pkgs.gnome-tweaks
  ];

  # Disable the SSH integration provided by Gnome Seahorse.
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/seahorse.nix
  # The SSH module still defines SSH_ASKPASS, but at least it is empty...
  programs.ssh.enableAskPassword = false;

  # Disable the SSH agent provided by Gnome Keyring.
  # https://discourse.nixos.org/t/disable-ssh-agent-from-gnome-keyring-on-gnome/28176/5
  # https://github.com/NixOS/nixpkgs/issues/166887
  nixpkgs.overlays = [
    (_: previous: {
      gnome-keyring = previous.gnome-keyring.overrideAttrs (
        _: previousAttrs: {
          configureFlags = previousAttrs.configureFlags or [ ] ++ [ "--disable-ssh-agent" ];
        }
      );
    })
  ];

  services.xserver.enable = true;

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  services.xserver.excludePackages = [
    # These excluded packages are derived from the Nixos module for XServer:
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/xserver.nix

    # pkgs.xorg.iceauth
    # pkgs.xorg.setxkbmap
    # pkgs.xorg.xauth
    # pkgs.xorg.xf86inputevdev.out
    # pkgs.xorg.xinput
    # pkgs.xorg.xlsclients
    # pkgs.xorg.xorgserver.out
    # pkgs.xorg.xprop
    # pkgs.xorg.xrandr
    # pkgs.xorg.xrdb
    # pkgs.xorg.xset
    # pkgs.xorg.xsetroot
    pkgs.xterm
  ];
}
