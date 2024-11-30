{ settings, ... }:
{
  networking.hostName = settings.hostName;

  services.avahi = {
    enable = true;

    nssmdns4 = true;

    publish = {
      enable = true;

      addresses = true;
      domain = true;
      workstation = true;
    };
  };

  services.openssh = {
    enable = true;

    startWhenNeeded = true;
  };
}
