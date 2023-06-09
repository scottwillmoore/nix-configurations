{packages, ...}: {
  # An asterisk (*) indicates that a Home Manager module exists...

  home.packages = with packages; let
    # https://wiki.archlinux.org/title/Archiving_and_compression
    # https://wiki.archlinux.org/title/Core_utilities
    # https://wiki.archlinux.org/title/Network_tools
    essentialUtilities = [
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
      less # (*)
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
      bat # https://github.com/sharkdp/bat (*)
      bottom # https://github.com/ClementTsang/bottom (*)
      delta # https://github.com/dandavison/delta
      du-dust # https://github.com/bootandy/dust
      exa # https://github.com/ogham/exa (*)
      fd # https://github.com/sharkdp/fd
      fzf # https://github.com/junegunn/fzf (*)
      # helix # https://github.com/helix-editor/helix (*)
      hyperfine # https://github.com/sharkdp/hyperfine
      jq # https://github.com/jqlang/jq (*)
      ripgrep # https://github.com/BurntSushi/ripgrep
      tealdeer # https://github.com/dbrgn/tealdeer (*)
      # zellij # https://github.com/zellij-org/zellij (*)
    ];

    # https://github.com/nix-community/awesome-nix
    nixPackages = [
      alejandra
      nil
    ];
  in
    essentialUtilities ++ modernUtilities ++ nixPackages;
}
