{
  # Keyboard

  console.useXkbConfig = true;

  services.xserver.xkb.options = "caps:escape";

  # Language

  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings.LANGUAGE = "en_AU:en_GB:en_US:en";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_AU.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  # Location

  location.provider = "geoclue2";

  # Time

  time.timeZone = "Australia/Melbourne";
}
