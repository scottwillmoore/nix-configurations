{ config, lib, ... }:
let
  readlinePath = [
    "programs"
    "readline"
  ];

  readline = lib.getAttrFromPath readlinePath config;

  configPath = "${config.xdg.configHome}/readline";

  inputrcPath = "${configPath}/inputrc";
in
{
  disabledModules = [
    "programs/readline.nix"
  ];

  options = lib.setAttrByPath readlinePath {
    enable = lib.mkEnableOption "Readline";
  };

  config = lib.mkIf readline.enable {
    assertions = [
      {
        assertion = config.xdg.enable;
        message = "XDG directories are required";
      }
    ];

    home.sessionVariables.INPUTRC = inputrcPath;

    home.file."${inputrcPath}" = lib.mkIf (readline.config != null) {
      text = "";
    };
  };
}
