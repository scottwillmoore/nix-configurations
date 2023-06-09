{...}: {
  programs.bash.enable = true;

  programs.bash = {
    historyFileSize = 16 * 1024;
    historySize = 16 * 1024 * 1024;
    shellOptions = [
      "autocd"
      "cdspell"
      "dirspell"
      "extglob"
      "globstar"
      "histappend"
      "histverify"
    ];
  };
}
