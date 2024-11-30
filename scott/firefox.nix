{ lib, pkgs, ... }:
let
  colloid-firefox-theme = pkgs.colloid-gtk-theme.overrideAttrs {
    pname = "colloid-firefox-theme";

    buildInputs = [ ];
    nativeBuildInputs = [ ];
    propagatedUserEnvPkgs = [ ];

    installPhase = ''
      cp -r ./src/other/firefox/chrome/ $out/

      echo '@import "Colloid/theme.css";' > $out/userChrome.css
      rm $out/customChrome.css
    '';

    meta = {
      description = "A modern and clean Firefox theme";
      platforms = lib.platforms.all;
    };
  };

  firefox-gnome-theme = { };
in
{
  # Maybe declarative Firefox profiles are too heavy-handed?
  # Would it be better just to apply userChrome and userContent and leave settings to Firefox Sync?
  # What about language packs?
  # What else...?
  # Also the Colloid Firefox theme seemed broken/bad?
  # TODO: SET UP GIT WITH GPG!

  programs.firefox.enable = false;
  programs.firefox.package = pkgs.firefox;

  # programs.firefox.policies = {
  #   DisablePocket = true;
  #   Homepage = "about:blank";
  #   NoDefaultBookmarks = true;
  #   OverrideFirstRunPage = "";
  #   OverridePostUpdatePage = "";
  #   PasswordManagerEnabled = false;
  # };

  programs.firefox.languagePacks = [
    "en-GB"
    "en-US"
  ];

  programs.firefox.profiles.default = {
    # extensions = { };

    settings = {
      "app.normandy.first_run" = false;
      "browser.aboutConfig.showWarning" = false;
      "browser.contentblocking.category" = "strict";
      "browser.newtabpage.enabled" = false;
      "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
      "privacy.fingerprintingProtection" = true;
      "privacy.trackingprotection.emailtracking.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "sidebar.position_start" = false;
      "signon.rememberSignons" = false;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

      # "browser.startup.page" = 3;
      # "services.sync.username" = settings.emailAddress;
    };

    userChrome = ''
      @import "${colloid-firefox-theme}/userChrome.css";
    '';

    userContent = ''
      @import "${colloid-firefox-theme}/userContent.css";
    '';
  };
}
