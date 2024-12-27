{
  # Language

  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LANGUAGE = "en_AU:en_GB:en_US:en";
  };

  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_AU.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  # Location

  location.provider = "geoclue2";

  # https://github.com/NixOS/nixpkgs/issues/321121
  # https://gitlab.archlinux.org/archlinux/packaging/packages/geoclue
  # The Mozilla Location Service (MLS) has been shutdown. Therefore, until a
  # replacement has been found use the Google Geolocation API and borrow the
  # Arch Linux API key... Sorry!
  services.geoclue2.geoProviderUrl =
    let
      apiKey = "AIzaSyDwr302FpOSkGRpLlUpPThNTDPbXcIn_FM";
    in
    "https://www.googleapis.com/geolocation/v1/geolocate?key=${apiKey}";

  # Time

  time.timeZone = "Australia/Melbourne";
}
