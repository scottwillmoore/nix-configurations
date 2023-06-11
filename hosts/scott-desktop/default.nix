{
  inputs,
  packages,
  settings,
  ...
}: {
  imports = [
    inputs.wsl.nixosModules.default
  ];

  console.enable = false;

  environment.sessionVariables.LANGUAGE = "en_AU:en_GB:en_US:en";

  environment.systemPackages = with packages; [
    git
    home-manager
  ];

  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_AU.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  networking.hostName = settings.hostName;

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = ["flakes" "nix-command"];
      keep-derivations = true;
      keep-outputs = true;
    };
  };

  system.stateVersion = "22.11";

  time.timeZone = "Australia/Melbourne";

  users = {
    mutableUsers = false;
    users.${settings.userName} = {
      extraGroups = ["wheel"];
      hashedPassword = "$y$j9T$7YZRel/.UA77o5N3iyS8D.$8XD/qLKUkKHOH7OQVLEQOQS84AFHkxpmS9mPMSVT3o3";
      isNormalUser = true;
    };
  };

  wsl = {
    defaultUser = settings.userName;
    enable = true;
    wslConf.interop.appendWindowsPath = false;
  };
}
