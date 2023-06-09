{settings, ...}: {
  # NOTE: A good candidate for replacement...

  programs.git.enable = true;

  programs.git = {
    lfs.enable = true;

    extraConfig = {
      commit.gpgSign = true;
      init.defaultBranch = "main";
      pull.ff = "only";
      push.autoSetupRemote = true;
      push.followTags = true;
      status.submoduleSummary = true;
      tag.gpgSign = true;
      user.email = settings.emailAddress;
      user.name = settings.fullName;
    };
  };
}
