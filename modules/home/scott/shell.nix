{ lib, pkgs, ... }:
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
    };
  };

  programs.bash = {
    enable = true;

    historyControl = [
      "ignorespace"
    ];

    # The maximum number of commands to remember on disk.
    historyFileSize = 1024 * 1024;

    # The maximum number of commands to remember in memory.
    historySize = 1024 * 1024;

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

  # programs.carapace.enable = true;

  programs.fish = {
    enable = true;

    plugins = with pkgs.fishPlugins; [
      {
        name = "autopair";
        inherit (autopair) src;
      }
      {
        name = "tide";
        inherit (tide) src;
      }
    ];

    interactiveShellInit = ''
      set fish_greeting

      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace underscore
      set fish_cursor_replace_one underscore

      fish_vi_key_bindings
    '';
  };

  home.activation.configure-tide = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.fish}/bin/fish -c "tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Compact --icons='Few icons' --transient=Yes"
  '';

  programs.zoxide.enable = true;
}
