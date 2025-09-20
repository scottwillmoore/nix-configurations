{ settings, ... }:
{
  networking.hostName = settings.hostName;

  services.avahi.enable = true;
  services.avahi = {
    nssmdns4 = true;

    publish = {
      enable = true;

      addresses = true;
      domain = true;
      workstation = true;
    };
  };

  services.openssh.enable = true;
  services.openssh = {
    startWhenNeeded = true;
  };
}
