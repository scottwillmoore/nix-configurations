{
  packages,
  settings,
  ...
}: {
  home = {
    homeDirectory = "/home/${settings.userName}";
    packages = with packages; [
      alejandra
    ];
    stateVersion = "22.11";
    username = settings.userName;
  };

  programs = {
    bash.enable = true;

    dircolors.enable = true;

    git = {
      enable = true;

      signing = {
        key = "D6FF1BE917C2FCDF";
        signByDefault = true;
      };
      userEmail = settings.emailAddress;
      userName = settings.fullName;
    };

    gpg.enable = true;

    home-manager.enable = true;

    man.enable = true;

    ssh.enable = true;

    starship.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;

      defaultCacheTtl = 15 * 60;
      defaultCacheTtlSsh = 15 * 60;
      enableSshSupport = true;
      maxCacheTtl = 60 * 60;
      maxCacheTtlSsh = 60 * 60;
      pinentryFlavor = "tty";
      sshKeys = ["6C560B0B5F2146329B7AC36992F7186F2EE51AD4"];
    };
  };
}
