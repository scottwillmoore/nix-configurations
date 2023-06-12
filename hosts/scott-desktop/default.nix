{
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

  environment.sessionVariables."LANGUAGE" = "en_AU:en_GB:en_US:en";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.supportedLocales = ["C.UTF-8/UTF-8" "en_AU.UTF-8/UTF-8" "en_GB.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];

  networking.hostName = settings.hostName;

  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  # https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;

  # Enable Nix flakes.
  # https://nixos.wiki/wiki/Flakes#Enable_flakes
  nix.settings.experimental-features = ["flakes" "nix-command"];

  # https://github.com/nix-community/nix-direnv#Installation
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-keep-outputs
  nix.settings.keep-outputs = true;

  nixpkgs.hostPlatform = settings.hostPlatform;

  # programs.fish.enable = true;

  time.timeZone = "Australia/Melbourne";

  # Use immutable users whereby files such as /etc/passwd and /etc/group are managed by Nix.
  users.mutableUsers = false;

  # Create a user.
  users.users.${settings.userName} = {
    extraGroups = ["wheel"];
    hashedPassword = "$y$j9T$7YZRel/.UA77o5N3iyS8D.$8XD/qLKUkKHOH7OQVLEQOQS84AFHkxpmS9mPMSVT3o3";
    isNormalUser = true;
    # shell = packages.fish;
  };

  # Enable WSL integration with NixOS.
  wsl = {
    enable = true;

    defaultUser = settings.userName;

    # Use the native Systemd provided by WSL.
    # https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/
    # https://github.com/nix-community/NixOS-WSL/issues/201
    # At the moment there is a problem with the Visual Studio Code server and the native Systemd.
    # https://github.com/nix-community/NixOS-WSL/issues/231
    # nativeSystemd = true;

    # Do not append the Windows PATH to the Linux environment as it is slow!
    # https://github.com/microsoft/WSL/issues/4234
    # https://learn.microsoft.com/en-us/windows/wsl/wsl-config#interop-settings
    wslConf.interop.appendWindowsPath = false;
  };
}
