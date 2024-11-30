{ settings, ... }:
{
  imports = [ ./git.module.nix ];

  programs.git = {
    enable = true;

    config = {
      # Credentials
      commit.gpgSign = true;
      tag.gpgSign = true;
      user.email = settings.emailAddress;
      user.name = settings.fullName;
      user.signingKey = "D6FF1BE917C2FCDF";

      # Options
      branch.sort = "-committerdate";
      init.defaultBranch = "main";
      log.date = "human";
      pull.ff = "only";
      push.autoSetupRemote = true;
      push.followTags = true;
      rebase.autoSquash = true;
      rebase.autoStash = true;
      tag.sort = "-version:refname";
    };

    ignores = [
      ".[Aa]pple[Dd]ouble"
      ".[Dd][Ss]_[Ss]tore"
      "._*"
      "[Dd]esktop.ini"
      "[Tt]humbs.db"
    ];
  };
}
