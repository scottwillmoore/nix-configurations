{ config, lib, ... }:
let
  inherit (lib) types;
in
{
  options = {
    settings = {
      # Host

      computerName = lib.mkOption {
        type = types.str;
      };

      hostName = lib.mkOption {
        type = types.str;
      };

      hostPlatform = lib.mkOption {
        type = types.str;
      };

      # User

      emailAddress = lib.mkOption {
        type = types.str;
      };

      fullName = lib.mkOption {
        type = types.str;
      };

      hashedPassword = lib.mkOption {
        type = types.str;
      };

      userName = lib.mkOption {
        type = types.str;
      };
    };
  };

  config._module.args.settings = config.settings;
}
