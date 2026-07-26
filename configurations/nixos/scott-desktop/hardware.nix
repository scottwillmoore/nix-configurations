{ config, ... }:
{
  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = true;

  # CPU

  hardware.cpu.intel.updateMicrocode = true;
  # TODO: https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/intel/coffee-lake/default.nix

  # Ethernet

  networking.firewall.trustedInterfaces = [
    "eno1"
  ];

  # GPU

  # boot.initrd.kernelModules = [
  #   "nvidia"
  #   "nvidia_modeset"
  #   "nvidia_drm"
  # ];
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  hardware.nvidia.powerManagement.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # SSD

  services.fstrim.enable = true;
}
