{packages, ...}: {
  # An asterisk (*) indicates that a module exists...

  home.packages = with packages; let
    # https://wiki.archlinux.org/title/Archiving_and_compression
    # https://wiki.archlinux.org/title/Core_utilities
    # https://wiki.archlinux.org/title/Network_tools
    esentialUtilities = [
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
      less # *
      netcat
      p7zip
      rar
      time
      traceroute
      unzip
      wget
      xz
      zip
    ];

    # https://github.com/ibraheemdev/modern-unix
    # https://news.ycombinator.com/item?id=26559334
    # https://wiki.archlinux.org/title/Core_utilities#Alternatives
    modernUtilities = [
      # https://github.com/sharkdp/bat
      bat # *
      # https://github.com/ClementTsang/bottom
      bottom # *
      # https://github.com/dandavison/delta
      delta
      # https://github.com/bootandy/dust
      du-dust
      # https://github.com/ogham/exa
      exa # *
      # https://github.com/sharkdp/fd
      fd
      # https://github.com/junegunn/fzf
      fzf # *
      # https://github.com/helix-editor/helix
      # helix # *
      # https://github.com/sharkdp/hyperfine
      hyperfine
      # https://github.com/jqlang/jq
      jq # *
      # https://github.com/BurntSushi/ripgrep
      ripgrep
      # https://github.com/dbrgn/tealdeer
      tealdeer # *
      # https://github.com/zellij-org/zellij
      # zellij # *
    ];

    # https://github.com/nix-community/awesome-nix
    nixUtilities = [
      alejandra
      nil
    ];
  in
    esentialUtilities ++ modernUtilities ++ nixUtilities;
}
