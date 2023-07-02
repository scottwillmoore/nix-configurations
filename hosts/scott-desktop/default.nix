{
  functions,
  inputs,
  packages,
  settings,
  ...
}: {
  imports = [
    inputs.wsl.nixosModules.default
  ];

  # https://nixos.org/manual/nixos/unstable/options.html#opt-system.stateVersion
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";

  environment.systemPackages = with packages; [
    git
    home-manager
  ];

  # Set the preferred locales.
  environment.sessionVariables."LANGUAGE" = "en_AU:en_GB:en_US:en";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.supportedLocales = ["C.UTF-8/UTF-8" "en_AU.UTF-8/UTF-8" "en_GB.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];

  # Set the host name.
  networking.hostName = settings.hostName;

  # Set the time zone.
  time.timeZone = "Australia/Melbourne";

  # Enable Nix flakes.
  # https://nixos.wiki/wiki/Flakes#Enable_flakes
  nix.settings.experimental-features = ["flakes" "nix-command"];

  # Use a binary cache.
  # https://nixos.wiki/wiki/Binary_Cache#Using_a_binary_cache
  # https://github.com/numtide/nixpkgs-unfree
  # The use of `mkForce` is required to override the default configuration.
  # https://github.com/NixOS/nixpkgs/blob/nixos-23.05/nixos/modules/services/misc/nix-daemon.nix#L814C24-L814C24
  nix.settings = {
    substituters = functions.mkForce [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = functions.mkForce [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  # https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;

  # https://nixos.org/manual/nix/stable/advanced-topics/distributed-builds.html
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-builders-use-substitutes
  nix.settings.builders-use-substitutes = true;

  # https://github.com/nix-community/nix-direnv#Installation
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-keep-outputs
  nix.settings.keep-outputs = true;

  # TODO: Investigate using Fish as my default shell environment.
  # programs.fish.enable = true;

  # Use `nix-ld` to run unpatched, dynamically linked binaries.
  # https://github.com/Mic92/nix-ld
  programs.nix-ld.enable = true;

  # Use immutable users where files such as `/etc/passwd` are managed by Nix.
  users.mutableUsers = false;

  # Create a user for me!
  users.users.${settings.userName} = {
    extraGroups = ["wheel"];
    hashedPassword = "$y$j9T$7YZRel/.UA77o5N3iyS8D.$8XD/qLKUkKHOH7OQVLEQOQS84AFHkxpmS9mPMSVT3o3";
    isNormalUser = true;
    # TODO: Investigate using Fish as my default shell environment.
    # shell = packages.fish;
  };

  # Enable WSL integration with NixOS.
  wsl = {
    enable = true;

    defaultUser = settings.userName;

    # Use the native Systemd provided by WSL.
    # https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/
    # https://github.com/nix-community/NixOS-WSL/issues/201
    # Although, at the moment there is a problem with the Visual Studio Code
    # server and the native Systemd, therefore do not use the native Systemd...
    # https://github.com/nix-community/NixOS-WSL/issues/231
    # nativeSystemd = true;

    # Do not append the Windows PATH to the Linux environment as it is slow!
    # https://github.com/microsoft/WSL/issues/4234
    # https://learn.microsoft.com/en-us/windows/wsl/wsl-config#interop-settings
    wslConf.interop.appendWindowsPath = false;
  };
}
