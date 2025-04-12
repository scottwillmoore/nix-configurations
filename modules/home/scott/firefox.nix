{ pkgs, ... }:
let
  firefox-gnome-theme = pkgs.fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    tag = "v137";

    hash = "sha256-oiHLDHXq7ymsMVYSg92dD1OLnKLQoU/Gf2F1GoONLCE=";
  };
in
{
  # Maybe declarative Firefox profiles are too heavy-handed?
  # Would it be better just to apply `userChrome.css` and `userContent.css` and leave settings to Firefox Sync?
  # What settings are synced and therefore what settings should be put in `user.js`.
  # What about language packs?
  # What about policies?

  programs.firefox = {
    enable = true;

    package = null;

    profiles.default = {
      settings = {
        "app.normandy.first_run" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.newtabpage.enabled" = false;
        "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
        "sidebar.position_start" = false;
        "signon.rememberSignons" = false;

        # "browser.contentblocking.category" = "strict";
        # "privacy.fingerprintingProtection" = true;
        # "privacy.trackingprotection.emailtracking.enabled" = true;
        # "privacy.trackingprotection.enabled" = true;
        # "privacy.trackingprotection.socialtracking.enabled" = true;

        # https://github.com/rafaelmardojai/firefox-gnome-theme/blob/master/configuration/user.js
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.uidensity" = 0;
        "svg.context-properties.content.enabled" = true;
        "browser.theme.dark-private-windows" = false;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
      };

      userChrome = ''
        @import "${firefox-gnome-theme}/userChrome.css";

        #TabsToolbar:not([customizing]) {
          visibility: collapse;
        }
      '';

      userContent = ''
        @import "${firefox-gnome-theme}/userContent.css";
      '';
    };
  };
}
