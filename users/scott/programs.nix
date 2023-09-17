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

  programs.bat = {
    enable = true;

    config.theme = "ansi";
  };

  programs.command-not-found.enable = true;

  programs.direnv = {
    enable = true;

    config.whitelist.prefix = ["/home/${settings.userName}/repositories/scottwillmoore"];
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;

    aliases = {
      "graph" = "log --date=human --graph --pretty='%C(bold red)%<(12,trunc)%H%C(reset) (%C(red)%D%C(reset)) at %C(bold green)%ad%C(reset) (%C(green)%ar%C(reset)) by %C(bold blue)%an%C(reset) (%C(blue)%G?%C(reset), %C(blue)%GK%C(reset))%n> %s'";
      "latest" = "log --max-count=1 --stat";
      "short" = "log --oneline";
    };

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
