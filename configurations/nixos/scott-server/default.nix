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

  boot.initrd.availableKernelModules = [
    "e1000e"
  ];

  boot.initrd.network.enable = true;

  boot.initrd.network.ssh.enable = true;
  boot.initrd.network.ssh.port = 2222;
  boot.initrd.network.ssh.hostKeys = [
    "/etc/ssh/initrd_ssh_host_ed25519_key"
  ];

  boot.initrd.systemd.network.networks."10-eno1" = {
    matchConfig = {
      Name = "eno1";
    };
    networkConfig = {
      DHCP = "yes";
      MulticastDNS = true;
    };
  };

  boot.initrd.services.resolved.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHpwam0hQH7uJUC6DfeApxxHQ07t47SzSVT/kHmOgDkT"
  ];
}
