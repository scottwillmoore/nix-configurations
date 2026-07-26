{ pkgs, ... }: {
  imports = [
    ./common.module.nix
    ./machine-info.module.nix

    ./boot.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
  ];

  system.stateVersion = "25.05";

  environment.systemPackages = with pkgs; [
    # Development
    git
    neovim

    # Shell
    curl
    file
    zip
    unzip
    zip

    # System
    binutils
    pciutils
    usbutils
  ];
}
