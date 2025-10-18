{ config, inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    # inputs.nixos-hardware.nixosModules.common-cpu-intel
    # inputs.nixos-hardware.nixosModules.common-gpu-nvidia-disable
    # inputs.nixos-hardware.nixosModules.common-gpu-intel-disable
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "usbhid"
    "xhci_pci"
  ];

  # Nvidia
  # boot.initrd.kernelModules = [
  #   "nvidia"
  #   "nvidia_modeset"
  #   "nvidia_drm"
  # ];

  # Nvidia
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  hardware.nvidia.powerManagement.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
}
