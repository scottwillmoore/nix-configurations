{ outputs, ... }:
{
  imports = [
    outputs.nixosModules.common

    ./file-system.nix
    ./hardware.nix
  ];

  settings = {
    computerName = "Scott's Server";
    hostName = "scott-server";
    hostPlatform = "x86_64-linux";
  };
}
