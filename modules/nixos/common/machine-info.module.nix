# TODO
# https://www.freedesktop.org/software/systemd/man/latest/machine-info.html
{ config, lib, ... }:
let
  inherit (lib) types;

  machineInfoType = types.submodule {
    freeformType = types.attrsOf types.string;
    options = {
      CHASSIS = lib.mkOption {
        description = ''
          The chassis type.
        '';

        default = null;
        type = types.nullOr (
          types.enum [
            "container"
            "convertible"
            "desktop"
            "embedded"
            "handset"
            "laptop"
            "server"
            "tablet"
            "vm"
            "watch"
          ]
        );
      };

      DEPLOYMENT = lib.mkOption {
        description = ''
          The system deployment environment.
        '';

        default = null;
        type = types.nullOr (
          types.enum [
            "development"
            "integration"
            "production"
            "staging"
          ]
        );
      };

      LOCATION = lib.mkOption {
        description = ''
          The system location if applicable and known.
        '';

        default = null;
        type = types.nullOr types.str;
      };

      ICON_NAME = lib.mkOption {
        description = ''
          An icon identifying this machine according to the XDG Icon Naming Specification.
        '';

        default = null;
        type = types.nullOr types.str;
      };

      PRETTY_HOSTNAME = lib.mkOption {
        description = ''
          A pretty human-readable UTF-8 machine identifier string.
        '';

        default = null;
        type = types.nullOr types.str;
      };

    };
  };
in
{
  options = {
    environment.machineInfo = lib.mkOption {
      description = ''
        Set of variables to be used in `/etc/machine-info`.

        See `machine-info(5)`.
      '';

      default = { };
      type = types.nullOr machineInfoType;
    };
  };

  config =
    let
      generateText = lib.generators.toKeyValue {
        mkKeyValue = lib.generators.mkKeyValueDefault {
          mkValueString =
            value:
            lib.generators.mkValueStringDefault { } (
              if lib.isString value then
                ''"${lib.replaceStrings [ "\n" "\"" "\\" ] [ ''\n'' ''\"'' ''\\'' ] value}"''
              else
                value
            );
        } "=";
      };

    in
    {
      environment.etc.machine-info = lib.mkIf (config.environment.machineInfo != null) {
        text = generateText (lib.filterAttrs (name: value: value != null) config.environment.machineInfo);
      };
    };
}
