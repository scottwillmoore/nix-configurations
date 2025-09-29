{ settings, ... }:
{
  networking.firewall.enable = true;
  networking.firewall = {
    allowedTCPPorts = [ 8080 ];
  };

  networking.hostName = settings.hostName;

  services.avahi.enable = true;
  services.avahi = {
    nssmdns4 = true;

    publish.enable = true;
    publish = {
      addresses = true;
      domain = true;
      userServices = true;
      workstation = true;
    };
  };

  services.openssh.enable = true;
  services.openssh = {
    startWhenNeeded = true;
  };

  # TODO: Printing shouldn't be enabled on all my devices.
  services.printing.enable = true;

  # TODO: Add a Tailscale network for my devices.
  # services.tailscale.enable = true;
}
