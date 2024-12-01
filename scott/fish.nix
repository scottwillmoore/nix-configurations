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

  programs.carapace.enable = true;

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

  programs.kitty = {
    enable = true;

    font.name = "Iosevka";
    font.size = 16;

    settings = {
      scrollback_lines = 1024;

      enable_audio_bell = false;

      mouse_hide_wait = 1;

      hide_window_decorations = true;

      tab_bar_style = "powerline";
      tab_bar_min_tabs = 1;
    };

    theme = "Tokyo Night";

    extraConfig = ''
      # https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points (v3.3.0)
      symbol_map U+23FB-U+23FE Symbols Nerd Font Mono
      symbol_map U+2665 Symbols Nerd Font Mono
      symbol_map U+26A1 Symbols Nerd Font Mono
      symbol_map U+2B58 Symbols Nerd Font Mono
      symbol_map U+E000-U+E00A Symbols Nerd Font Mono
      symbol_map U+E0A0-U+E0A2 Symbols Nerd Font Mono
      symbol_map U+E0A3 Symbols Nerd Font Mono
      symbol_map U+E0B0-U+E0B3 Symbols Nerd Font Mono
      symbol_map U+E0B4-U+E0C8 Symbols Nerd Font Mono
      symbol_map U+E0CA Symbols Nerd Font Mono
      symbol_map U+E0CC-U+E0D7 Symbols Nerd Font Mono
      symbol_map U+E200-U+E2A9 Symbols Nerd Font Mono
      symbol_map U+E300-U+E3E3 Symbols Nerd Font Mono
      symbol_map U+E5FA-U+E6B7 Symbols Nerd Font Mono
      symbol_map U+E700-U+E8EF Symbols Nerd Font Mono
      symbol_map U+EA60-U+EC1E Symbols Nerd Font Mono
      symbol_map U+ED00-U+EFCE Symbols Nerd Font Mono
      symbol_map U+F000-U+F2FF Symbols Nerd Font Mono
      symbol_map U+F300-U+F381 Symbols Nerd Font Mono
      symbol_map U+F400-U+F533 Symbols Nerd Font Mono
      symbol_map U+F500-U+FD46 Symbols Nerd Font Mono
      symbol_map U+F0001-U+F1AF0 Symbols Nerd Font Mono
    '';
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
