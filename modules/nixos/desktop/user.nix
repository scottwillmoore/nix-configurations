{ settings, ... }:
{
  users = {
    mutableUsers = false;

    users.${settings.userName} = {
      description = settings.fullName;
      extraGroups = [ "wheel" ];
      hashedPassword = settings.hashedPassword;
      isNormalUser = true;
    };
  };
}
