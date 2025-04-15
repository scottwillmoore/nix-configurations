{ inputs, ... }:
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
        @import "${inputs.firefox-gnome-theme}/userChrome.css";

        /* Hide horizontal tabs. */
        #TabsToolbar:not([customizing]) {
          visibility: collapse !important;
        }

        /* Fix (what I think is) a bug in Firefox whereby a right-aligned sidebar
         * has a thick border between it and the page content. This does not
         * appear in a left-aligned sidebar. */
        #sidebar-box {
          @media -moz-pref("sidebar.revamp") {
            &[positionend] {
              margin-inline-start: 0 !important;
            }
          }
        }
      '';

      userContent = ''
        @import "${inputs.firefox-gnome-theme}/userContent.css";
      '';
    };
  };
}
