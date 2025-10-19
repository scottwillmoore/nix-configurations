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

  users.users.${settings.userName} = {
    shell = pkgs.fish;

    extraGroups = [
      # https://github.com/NixOS/nixpkgs/issues/222943
      "networkmanager"
    ];
  };
}
