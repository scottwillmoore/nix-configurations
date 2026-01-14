{
  services.udev.extraRules = ''
    # Nuphy Air 75 V3
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="19f5", ATTRS{idProduct}=="1028", MODE="0666"
    # Nuphy Air 75 V3 Dongle
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="19f5", ATTRS{idProduct}=="2620", MODE="0666"
    # Nuphy Air 75 V3 Upgrader
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="19f5", ATTRS{idProduct}=="0722", MODE="0666"
  '';
}
