{settings, ...}: {
  # https://nix-community.github.io/home-manager/options.html#opt-home.stateVersion
  home.stateVersion = "23.05";

  # https://nix-community.github.io/home-manager/index.html#sec-usage-configuration
  home.homeDirectory = "/home/${settings.userName}";
  home.username = settings.userName;

  home.shellAliases."ls" = "exa";
  home.shellAliases."sudo" = "sudo";

  imports = [
    ./packages.nix

    ./programs/bash.nix
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/neovim.nix
    ./programs/readline.nix
    # ./programs/starship.nix
  ];

  programs.command-not-found.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.home-manager.enable = true;
  programs.man.enable = true;
  programs.ssh.enable = true;
  programs.starship.enable = true;
  programs.tmux.enable = true;
}
