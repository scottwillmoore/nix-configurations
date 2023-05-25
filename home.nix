{
  packages,
  settings,
  ...
}: {
  home = {
    homeDirectory = "/home/${settings.userName}";
    packages = with packages; [
      # https://wiki.archlinux.org/title/Archiving_and_compression
      # https://wiki.archlinux.org/title/Core_utilities
      # https://wiki.archlinux.org/title/Network_tools
      bzip2
      coreutils
      curl
      diffutils
      dig
      file
      findutils
      gawk
      gnugrep
      gnused
      gnutar
      gzip
      iputils
      less
      netcat
      p7zip
      rar
      time
      traceroute
      unzip
      wget
      xz
      zip

      # https://github.com/ibraheemdev/modern-unix
      # https://news.ycombinator.com/item?id=26559334
      # https://wiki.archlinux.org/title/Core_utilities#Alternatives
      bat
      bottom
      delta
      du-dust
      exa
      fd
      fzf
      hyperfine
      jq
      ripgrep
      tealdeer

      # https://github.com/nix-community/awesome-nix
      alejandra
      nil
    ];
    stateVersion = "22.11";
    username = settings.userName;
  };

  programs = {
    bash.enable = true;

    command-not-found.enable = true;

    dircolors.enable = true;

    direnv = {
      enable = true;

      nix-direnv.enable = true;
    };

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
