{ settings, ... }:
{
  environment.machineInfo.PRETTY_HOSTNAME = settings.computerName;
  networking.hostName = settings.hostName;

  # MDNS

  services.avahi.enable = true;
  services.avahi = {
    nssmdns4 = true;

    publish.enable = true;
    publish = {
      addresses = true;
      userServices = true;
    };
  };

  # SSH

  services.openssh.enable = true;
  services.openssh = {
    startWhenNeeded = true;
  };
}
