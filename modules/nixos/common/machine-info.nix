{ settings, ... }:
{
  imports = [
    ./machine-info.module.nix
  ];

  environment.machineInfo.PRETTY_HOSTNAME = settings.computerName;
}
