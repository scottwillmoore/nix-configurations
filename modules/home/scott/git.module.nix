{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;

  gitPath = [
    "programs"
    "git"
  ];

  git = lib.getAttrFromPath gitPath config;

  configPath = "${config.xdg.configHome}/git";

  configType =
    let
      primitiveType = types.oneOf [
        types.bool
        types.int
        types.str
      ];

      valueType = types.either primitiveType (types.listOf primitiveType);

      subSectionType = types.attrsOf valueType;

      sectionType = types.attrsOf (types.either valueType subSectionType);
    in
    types.attrsOf sectionType;
in
{
  disabledModules = [
    "programs/bun.nix"
    "programs/gh-dash.nix"
    "programs/gh.nix"
    "programs/git-credential-oauth.nix"
    "programs/git.nix"
  ];

  options = lib.setAttrByPath gitPath {
    enable = lib.mkEnableOption "Git";

    package = lib.mkPackageOption pkgs "Git" { default = [ "git" ]; };

    config = lib.mkOption {
      description = "The global configuration for Git.";
      type = types.nullOr configType;
      default = null;
    };

    ignore = lib.mkOption {
      description = "A global list of patterns that should be ignored.";
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = lib.mkIf git.enable {
    assertions = [
      {
        assertion = config.xdg.enable;
        message = "XDG directories are required";
      }
    ];

    home.packages = [ git.package ];

    home.file."${configPath}/config" = lib.mkIf (git.config != null) {
      text = lib.generators.toGitINI git.config;
    };

    home.file."${configPath}/ignore" = lib.mkIf (git.ignore != [ ]) {
      text = lib.concatStringsSep "\n" git.ignore;
    };
  };
}
