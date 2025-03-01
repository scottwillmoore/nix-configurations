{ lib, ... }:
{
  options = {
    settings = {
      emailAddress = lib.mkOption {
        type = lib.types.str;
      };

      fullName = lib.mkOption {
        type = lib.types.str;
      };

      userName = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
}
