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

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHpwam0hQH7uJUC6DfeApxxHQ07t47SzSVT/kHmOgDkT"
  ];
}
