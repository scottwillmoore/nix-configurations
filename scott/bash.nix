{
  programs.bash = {
    enable = true;

    # A list of values which control how commands are remembered.
    historyControl = [
      "ignorespace"
    ];

    # The maximum number of commands to remember on file.
    historyFileSize = 1024 * 1024;

    # The maximum number of commands to remember in memory.
    historySize = 1024 * 1024;

    # A list of values which control shell behaviour.
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
