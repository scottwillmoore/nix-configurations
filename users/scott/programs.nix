{settings, ...}: {
  imports = [
    ./programs/neovim.nix
    ./programs/readline.nix
    ./programs/starship.nix
  ];

  programs.bash = {
    enable = true;

    historyFileSize = 16 * 1024;
    historySize = 16 * 1024 * 1024;

    shellOptions = [
      "autocd"
      "cdspell"
      "dirspell"
      "extglob"
      "globstar"
      "histappend"
      "histverify"
    ];
  };

  programs.command-not-found.enable = true;

  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;

    lfs.enable = true;

    extraConfig = {
      commit.gpgSign = true;
      init.defaultBranch = "main";
      pull.ff = "only";
      push.autoSetupRemote = true;
      push.followTags = true;
      status.submoduleSummary = true;
      tag.gpgSign = true;
      user.email = settings.emailAddress;
      user.name = settings.fullName;
    };
  };

  programs.gpg.enable = true;

  programs.home-manager.enable = true;

  programs.man.enable = true;

  programs.ssh.enable = true;

  programs.tmux.enable = true;
}
