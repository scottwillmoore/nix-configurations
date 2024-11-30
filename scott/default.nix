{ pkgs, ... }:
{
  home.stateVersion = "24.05";

  imports = [
    ./desktop.nix
    ./firefox.nix
    ./fish.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
  ];

  home.packages = with pkgs; [
    # Applications
    firefox
    google-chrome
    vscode

    # Utilities
    curl
    fd
    ripgrep
    wget

    # Nickel
    nickel
    nls

    # Nix
    nh
    nixd
    nixfmt-rfc-style
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.enable = true;

  programs.bash.enable = true;

  programs.direnv = {
    enable = true;

    config.whitelist.prefix = [ "~/Repositories/scottwillmoore" ];
    silent = true;

    nix-direnv.enable = true;
  };

  # Restart services on switch.
  systemd.user.startServices = "sd-switch";
}
