{...}: {
  # NOTE: A good candidate for replacement...

  # NOTE: Use XDG Base Directories.
  # https://wiki.archlinux.org/title/XDG_Base_Directory#Support

  programs.readline = {
    enable = true;

    includeSystemConfig = false;

    extraConfig = ''
      set bell-style none
      set colored-stats on
      set completion-ignore-case on
      set completion-map-case on
      set completion-prefix-display-length 4
      set completion-query-items 64
      set echo-control-characters off
      set keyseq-timeout 16
      set mark-symlinked-directories on
      set show-all-if-ambiguous on
      set show-all-if-unmodified on

      set editing-mode vi
      set show-mode-in-prompt on
      set vi-cmd-mode-string "\1\e[2 q\2"
      set vi-ins-mode-string "\1\e[6 q\2"

      set keymap vi-command
      "\C-a": beginning-of-line
      "\C-e": end-of-line
      "\C-l": clear-screen
      "\C-n": next-history
      "\C-p": previous-history

      set keymap vi-insert
      "\C-a": beginning-of-line
      "\C-e": end-of-line
      "\C-l": clear-screen
      "\C-n": next-history
      "\C-p": previous-history
    '';
  };
}
