{ lib, pkgs, ... }:
let
  gnomeExtensions = [
    # https://extensions.gnome.org/extension/4269/alphabetical-app-grid/
    pkgs.gnomeExtensions.alphabetical-app-grid

    # https://extensions.gnome.org/extension/615/appindicator-support/
    pkgs.gnomeExtensions.appindicator

    # https://extensions.gnome.org/extension/6682/astra-monitor/
    pkgs.gnomeExtensions.astra-monitor

    # https://extensions.gnome.org/extension/3193/blur-my-shell/
    pkgs.gnomeExtensions.blur-my-shell

    # https://extensions.gnome.org/extension/600/launch-new-instance/
    pkgs.gnomeExtensions.launch-new-instance

    # https://extensions.gnome.org/extension/2236/night-theme-switcher/
    pkgs.gnomeExtensions.night-theme-switcher

    # https://extensions.gnome.org/extension/5940/quick-settings-audio-panel/
    pkgs.gnomeExtensions.quick-settings-audio-panel

    # https://extensions.gnome.org/extension/7048/rounded-window-corners-reborn/
    pkgs.gnomeExtensions.rounded-window-corners-reborn

    # https://extensions.gnome.org/extension/19/user-themes/
    pkgs.gnomeExtensions.user-themes
  ];
in
{
  dconf.enable = true;

  dconf.settings =
    let
      # There appears to be two implementations of `gvariant`...
      # https://github.com/nix-community/home-manager/blob/master/modules/lib/gvariant.nix
      # https://github.com/nixos/nixpkgs/blob/master/lib/gvariant.nix
      g = lib.hm.gvariant;

      recursiveUpdateList = lib.foldl lib.recursiveUpdate { };
    in
    recursiveUpdateList [
      # Basics
      {
        "org/gnome/desktop/app-folders" = {
          "folder-children" = g.mkArray g.type.string [ ];
        };
        "org/gnome/desktop/interface" = {
          "enable-hot-corners" = g.mkBoolean false;
          "font-antialiasing" = g.mkString "grayscale";
          "font-hinting" = g.mkString "full";
          "gtk-enable-primary-paste" = g.mkBoolean false;
        };
        "org/gnome/desktop/wm/keybindings" = {
          "switch-applications" = g.mkArray g.type.string [ ];
          "switch-applications-backward" = g.mkArray g.type.string [ ];
          "switch-windows" = g.mkArray g.type.string [ "<Super>Tab" ];
          "switch-windows-backward" = g.mkArray g.type.string [ "<Shift><Super>Tab" ];
        };
        "org/gnome/desktop/background" = {
          "picture-uri" = g.mkString "${./wallpapers/minimal-mojave-day.png}";
          "picture-uri-dark" = g.mkString "${./wallpapers/minimal-mojave-night.png}";
          "show-desktop-icons" = g.mkBoolean false;
        };
        "org/gnome/desktop/screensaver" = {
          "lock-enabled" = g.mkBoolean true;
          "lock-delay" = g.mkUint32 0;
        };
        "org/gnome/desktop/session" = {
          "idle-delay" = g.mkUint32 300; # 5 minutes
        };
        "org/gnome/desktop/wm/preferences" = {
          "button-layout" = g.mkString "appmenu:minimize,maximize,close";
        };
        "org/gnome/mutter" = {
          "attach-modal-dialogs" = g.mkBoolean false;
          "current-workspace-only" = g.mkBoolean false;
          "edge-tiling" = g.mkBoolean true;
          "workspaces-only-on-primary" = g.mkBoolean true;
        };
        "org/gnome/settings-daemon/plugins/color" = {
          "night-light-enabled" = g.mkBoolean true;
          "night-light-schedule-automatic" = g.mkBoolean true;
          "night-light-temperature" = g.mkUint32 2700;
        };
        "org/gnome/settings-daemon/plugins/power" = {
          "power-button-action" = g.mkString "suspend";
          "sleep-inactive-ac-timeout" = g.mkInt32 900; # 15 minutes
          "sleep-inactive-ac-type" = g.mkString "suspend";
        };
        "org/gnome/shell" = {
          "last-selected-power-profile" = g.mkString "performance";
        };
        "org/gnome/system/location" = {
          "enabled" = g.mkBoolean true;
        };
      }

      # Extensions
      {
        "org/gnome/shell" = {
          "disable-user-extensions" = g.mkBoolean false;
          "disabled-extensions" = g.mkArray g.type.string [ ];
          "enabled-extensions" = g.mkArray g.type.string (
            map (gnomeExtension: gnomeExtension.extensionUuid) gnomeExtensions
          );
        };
        "org/gnome/shell/extensions/appindicator" = {
          "icon-brightness" = g.mkDouble 1.0;
          "icon-opacity" = g.mkInt32 255;
          "icon-saturation" = g.mkDouble 1.0;
          "icon-size" = g.mkInt32 20;
        };
        "org/gnome/shell/extensions/blur-my-shell/panel" = {
          "override-background-dynamically" = g.mkBoolean true;
        };
        "org/gnome/shell/extensions/nightthemeswitcher/time" = {
          "manual-schedule" = g.mkBoolean false;
        };
      }

      # Themes
      {
        "org/gnome/desktop/interface" = {
          "monospace-font-name" = g.mkString "Iosevka 10";
        };
      }
    ];

  home.packages = gnomeExtensions;
}
