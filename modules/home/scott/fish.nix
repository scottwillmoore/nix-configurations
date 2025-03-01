{
  programs.atuin = {
    enable = true;

    flags = [
      "--disable-up-arrow"
    ];

    settings = {
      show_help = false;
      show_tabs = false;
      style = "compact";

      enter_accept = true;
      exit_mode = "return-query";

      # keymap_cursor.vim_insert = "steady-bar";
      # keymap_cursor.vim_normal = "steady-block";
      # keymap_mode = "auto";
    };
  };

  # programs.carapace.enable = true;

  programs.starship = {
    enable = true;

    enableTransience = true;

    settings = {
      command_timeout = 200;
      scan_timeout = 20;

      add_newline = false;
      format = "$character";
      right_format = "$all";
    };
  };

  programs.zoxide.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting

      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace underscore
      set fish_cursor_replace_one underscore
    '';
  };
}
