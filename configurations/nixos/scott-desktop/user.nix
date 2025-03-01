{
  inputs,
  pkgs,
  settings,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.backupFileExtension = "old";
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {
    inherit inputs;
    inherit settings;
  };

  home-manager.users.${settings.userName} = {
    imports = [ inputs.self.homeModules.scott ];
  };

  users.mutableUsers = false;

  users.users.${settings.userName} = {
    description = settings.fullName;
    hashedPassword = settings.hashedPassword;
    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "wheel"

      # https://github.com/NixOS/nixpkgs/issues/222943
      "networkmanager"
    ];
  };
}
