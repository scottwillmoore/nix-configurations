# TODO
# https://www.freedesktop.org/software/systemd/man/latest/machine-info.html
{ config, lib, ... }:
let
  inherit (lib) types;
in
{
  options = {
    environment = {
      machineInfo = lib.mkOption {
        description = ''
          Set of variables to be used in `/etc/machine-info`.

          See `machine-info(5)`.
        '';

        default = { };
        type = types.submodule {
          freeformType = types.attrsOf types.string;

          options = {
            PRETTY_HOST_NAME = lib.mkOption {
              description = ''
                A pretty human-readable UTF-8 machine identifier string.
              '';

              default = null;
              type = types.nullOr types.str;
            };

            CHASSIS = lib.mkOption {
              description = ''
                The chassis type.
              '';

              default = null;
              type = types.nullOr types.enum [
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
              ];
            };
          };
        };
      };
    };
  };

  config = {
    environment.etc.machine-info = lib.mkIf (config.environment.machineInfo.prettyHostName) {
      text = "";
    };
  };
}
