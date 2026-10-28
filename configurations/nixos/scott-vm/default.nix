{ outputs, ... }:
{
  imports = [
    outputs.nixosModules.common
  ];

  settings = {
    computerName = "Scott's VM";
    hostName = "scott-vm";
    hostPlatform = "x86_64-linux";
  };

  # This is required by `nix flake check` but ignored by QEMU.
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
}
