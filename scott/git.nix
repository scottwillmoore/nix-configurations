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
      blame.ignoreRevsFile = ".git-blame-ignore-revs";
      branch.sort = "-committerdate";
      commit.verbose = true;
      diff.algorithm = "histogram";
      diff.colorMoved = "default";
      fetch.prune = true;
      init.defaultBranch = "main";
      log.date = "human";
      merge.conflictStyle = "zdiff3";
      pull.ff = "only";
      push.autoSetupRemote = true;
      push.followTags = true;
      rebase.autoSquash = true;
      rebase.autoStash = true;
      rebase.missingCommitsCheck = "warn";
      rebase.updateRefs = true;
      rerere.enabled = true;
      tag.sort = "-version:refname";
    };

    ignore = [
      "._*"
      ".[Aa]pple[Dd]ouble"
      ".[Dd][Ss]_[Ss]tore"
      "[Dd]esktop.ini"
      "[Tt]humbs.db"
    ];
  };
}
