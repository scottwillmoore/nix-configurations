{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;

  gpgPath = [
    "programs"
    "gpg"
  ];

  gpg = lib.getAttrFromPath gpgPath config;

  gpgAgentPath = [
    "services"
    "gpg-agent"
  ];

  gpgAgent = lib.getAttrFromPath gpgAgentPath config;

  configType =
    let
      primitiveType = types.oneOf [
        types.bool
        types.str
      ];

      valueType = types.either primitiveType (types.listOf primitiveType);
    in
    types.attrsOf valueType;
in
{
  disabledModules = [
    "programs/gpg.nix"
    "services/gpg-agent.nix"
  ];

  options = lib.foldl' lib.recursiveUpdate { } [
    (lib.setAttrByPath gpgPath {
      enable = lib.mkEnableOption "GnuPG";

      package = lib.mkPackageOption pkgs "GnuPG" { default = [ "gnupg" ]; };

      config = lib.mkOption {
        description = "The configuration for GnuPG.";
        type = types.nullOr configType;
        default = null;
      };
    })

    (lib.setAttrByPath gpgAgentPath {
      enable = lib.mkEnableOption "GnuPG Agent";

      pinentryPackage = lib.mkPackageOption pkgs "pinentry" {
        nullable = true;
        default = [ "pinentry-curses" ];
        example = [ "pinentry-gnome3" ];
      };

      config = lib.mkOption {
        description = "The configuration for the GnuPG agent.";
        type = types.nullOr configType;
        default = null;
      };

      ssh = {
        enable = lib.mkEnableOption "GnuPG Agent (ssh)";

        keys = lib.mkOption {
          description = "The GPG keys (by keygrip) to expose as SSH keys.";
          type = types.nullOr (types.listOf types.str);
          default = null;
        };
      };

      systemd.enable = lib.mkEnableOption "GnuPG Agent (systemd)";
    })
  ];

  config = lib.mkIf gpg.enable (

    let
      configPath = "${config.xdg.configHome}/gnupg";

      toConfig = lib.generators.toKeyValue {
        listsAsDuplicateKeys = true;

        mkKeyValue =
          key: value:
          if lib.isString value then
            "${key} ${value}"
          else if lib.isBool value then
            lib.optionalString value key
          else
            abort "Unknown type of value: ${lib.typeOf value}";
      };
    in
    lib.mkMerge [
      {
        assertions = [
          {
            assertion = config.xdg.enable;
            message = "XDG directories must be enabled";
          }
        ];
      }

      # https://github.com/nix-community/home-manager/blob/master/modules/programs/gpg.nix
      # https://github.com/nixos/nixpkgs/blob/master/nixos/modules/programs/gnupg.nix
      {
        home.packages = [ gpg.package ];

        home.activation.createGPGConfigPath =
          lib.hm.dag.entryBetween [ "linkGeneration" ] [ "writeBoundary" ]
            ''
              run mkdir --mode=700 --parents $VERBOSE_ARG ${lib.escapeShellArg configPath}
            '';

        home.file."${configPath}/gpg.conf" = lib.mkIf (gpg.config != null) {
          text = toConfig gpg.config;
        };

        home.sessionVariables.GNUPGHOME = configPath;
      }

      # https://github.com/nix-community/home-manager/blob/master/modules/services/gpg-agent.nix
      (lib.mkIf gpgAgent.enable (
        lib.mkMerge [
          {
            home.file."${configPath}/gpg-agent.conf" = lib.mkIf (gpgAgent.config != null) {
              text = toConfig gpgAgent.config;
            };
          }

          (lib.mkIf (gpgAgent.pinentryPackage != null) (
            lib.setAttrByPath gpgAgentPath {
              config.pinentry-program = lib.getExe gpgAgent.pinentryPackage;
            }
          ))

          (lib.mkIf gpgAgent.ssh.enable (
            lib.mkMerge [
              {
                # https://wiki.archlinux.org/title/GnuPG#Using_a_PGP_key_for_SSH_authentication
                home.file."${configPath}/sshcontrol" = lib.mkIf (gpgAgent.ssh.keys != null) {
                  text = lib.concatMapStrings (key: key + "\n") gpgAgent.ssh.keys;
                };

                # https://wiki.archlinux.org/title/GnuPG#Set_SSH_AUTH_SOCK
                home.sessionVariables.SSH_AUTH_SOCK = "$(${gpg.package}/bin/gpgconf --list-dirs agent-ssh-socket)";

                # https://wiki.archlinux.org/title/GnuPG#Configure_pinentry_to_use_the_correct_TTY
                programs.ssh.config = ''Match host * exec "gpg-connect-agent UPDATESTARTUPTTY /bye"'';

              }

              (lib.setAttrByPath gpgAgentPath {
                config.enable-ssh-support = true;
              })
            ]
          ))
        ]
      ))
    ]
  );
}
