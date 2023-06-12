{inputs, ...}: let
  userName = "scott";
in {
  imports = [
    inputs.vscode-server.homeModules.default

    ./packages.nix
    ./programs.nix
    ./services.nix
  ];

  # https://nix-community.github.io/home-manager/options.html#opt-home.stateVersion
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  home.homeDirectory = "/home/${userName}";
  home.username = "${userName}";

  # Restart services on switch.
  systemd.user.startServices = "sd-switch";
}
