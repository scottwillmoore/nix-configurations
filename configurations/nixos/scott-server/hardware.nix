{
  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = true;

  # CPU

  hardware.cpu.intel.updateMicrocode = true;

  # SSD

  services.fstrim.enable = true;
}
