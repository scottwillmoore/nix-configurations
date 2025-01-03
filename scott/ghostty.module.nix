{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;

  ghosttyPath = [
    "programs"
    "ghostty"
  ];

  ghostty = lib.getAttrFromPath ghosttyPath config;

  configPath = "${config.xdg.configHome}/ghostty";

  configFormat = pkgs.formats.keyValue {
    listsAsDuplicateKeys = true;
    mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
  };
in
{
  disabledModules = [
    "programs/ghostty.nix"
  ];

  options = lib.setAttrByPath ghosttyPath {
    enable = lib.mkEnableOption "Ghostty";

    package = lib.mkPackageOption pkgs "Ghostty" { default = [ "ghostty" ]; };

    config = lib.mkOption {
      description = "The configuration for Ghostty.";
      type = types.nullOr configFormat.type;
      default = null;
    };
  };

  config = lib.mkIf ghostty.enable {
    assertions = [
      {
        assertion = config.xdg.enable;
        message = "XDG directories are required";
      }
    ];

    home.packages = [ ghostty.package ];

    home.file."${configPath}/config" = lib.mkIf (ghostty.config != null) {
      source = configFormat.generate "ghostty-config" ghostty.config;
    };
  };
}
