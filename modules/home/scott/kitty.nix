{ lib, ... }:
{
  programs.kitty = {
    enable = true;

    settings = {
      # Font
      font_family = "Iosevka";
      font_size = 16;
      symbol_map =
        let
          codePoints = lib.concatStringsSep "," [
            "U+23FB-U+23FE"
            "U+2665"
            "U+26A1"
            "U+2B58"
            "U+E000-U+E00A"
            "U+E0A0-U+E0A2"
            "U+E0A3"
            "U+E0B0-U+E0B3"
            "U+E0B4-U+E0C8"
            "U+E0CA"
            "U+E0CC-U+E0D7"
            "U+E200-U+E2A9"
            "U+E300-U+E3E3"
            "U+E5FA-U+E6B7"
            "U+E700-U+E8EF"
            "U+EA60-U+EC1E"
            "U+ED00-U+EFCE"
            "U+F000-U+F2FF"
            "U+F300-U+F381"
            "U+F400-U+F533"
            "U+F500-U+FD46"
            "U+F0001-U+F1AF0"
          ];
        in
        "${codePoints} Symbols Nerd Font";

      # Scrollback
      scrollback_lines = 1024;
      scrollback_pager_history_size = 128;

      # Terminal bell
      enable_audio_bell = false;

      # Mouse
      mouse_hide_wait = 1;

      # Window layout
      hide_window_decorations = true;

      # Tab bar
      tab_bar_style = "powerline";
      tab_bar_min_tabs = 1;
    };

    themeFile = "tokyo_night_night";
  };
}
