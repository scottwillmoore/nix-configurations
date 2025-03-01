{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;

  sshPath = [
    "programs"
    "ssh"
  ];

  ssh = lib.getAttrFromPath sshPath config;

  configPath = ".ssh";
in
{
  disabledModules = [
    "programs/ssh.nix"
  ];

  options = lib.setAttrByPath sshPath {
    enable = lib.mkEnableOption "SSH";

    package = lib.mkPackageOption pkgs "SSH" { default = [ "openssh" ]; };

    config = lib.mkOption {
      description = "The user's configuration for SSH.";
      type = types.nullOr types.lines;
      default = null;
    };
  };

  config = lib.mkIf ssh.enable {
    home.packages = lib.optional (ssh.package != null) ssh.package;

    home.file."${configPath}/config" = lib.mkIf (ssh.config != null) {
      text = ssh.config;
    };
  };
}
