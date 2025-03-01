{
  programs.kitty = {
    enable = true;

    font.name = "Iosevka";
    font.size = 16;

    settings = {
      scrollback_lines = 1024;
      scrollback_pager_history_size = 128;

      enable_audio_bell = false;

      mouse_hide_wait = 1;

      hide_window_decorations = true;

      tab_bar_style = "powerline";
      tab_bar_min_tabs = 1;
    };

    themeFile = "tokyo_night_night";

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
}
