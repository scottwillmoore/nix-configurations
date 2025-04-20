# The rendering of Unicode symbols in terminals is a complex topic which
# requires understanding of various topics:
# - East Asian width [0]
# - Private use areas [1]
# - Text segmentation ("grapheme clustering") [2], [3]
#
# There have even been proposed standards [4], [5] which are adopted by a
# collection of modern terminals (Countour, Ghostty, Kitty, ...).
#
# A Nerd Font [6] provides an extended set of glyphs that do not exist in the
# Unicode standard. To achieve this it uses the private use areas of Unicode to
# define these glyphs [1].
#
# By default the default Nerd Font variant [7] will design glyphs to be rendered
# as "wide" (two cells), however the Unicode standard defines all code points in
# the private use areas to be "narrow" (one cell).
#
# Despite this most terminals will allow glyphs that are too wide for their cell
# to be rendered across two cells provided that they are followed by a trailing
# space instead of clipping or shrinking the glyph.
#
# Therefore, a Nerd Font symbol should be trailed by a space. An emoji should
# NOT be trailed by space as it is "wide" and should already occupy two cells.
#
# [0] https://www.unicode.org/reports/tr11/
# [1] https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points
# [2] https://www.unicode.org/reports/tr29/
# [3] https://mitchellh.com/writing/grapheme-clusters-in-terminals
# [4] https://github.com/contour-terminal/terminal-unicode-core
# [5] https://sw.kovidgoyal.net/kitty/text-sizing-protocol/
# [6] https://github.com/ryanoasis/nerd-fonts
# [7] https://github.com/ryanoasis/nerd-fonts/discussions/1103
{ lib, ... }:
{
  programs.starship = {
    enable = false;

    enableTransience = true;

    settings = {
      add_newline = false;
      command_timeout = 200;
      scan_timeout = 20;

      format = "$character";
      right_format = "$all";
    };

    oldSettings = {
      add_newline = false;
      command_timeout = 200;
      scan_timeout = 20;

      # Formats

      format = lib.concatStrings [
        "$character"
      ];

      right_format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"

        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"

        "$direnv"
        "$nix_shell"

        "$shlvl"
        "$jobs"
        "$cmd_duration"
      ];

      # Modules

      username.format = "[  $user]($style)";
      # username.show_always = true;
      username.style_root = "bold red";
      username.style_user = "bold yellow";

      hostname.format = " [  $hostname]($style)";
      # hostname.ssh_only = false;
      hostname.style = "bold green";

      directory.format = " [  $path]($style)";
      # directory.read_only = " ";
      directory.style = "bold cyan";

      git_branch.format = " [  $branch(:$remote_branch)]($style)";
      git_branch.only_attached = true;
      git_branch.style = "bold purple";

      git_commit.format = " [  $hash(   $tag)]($style)";
      git_commit.only_detached = true;
      git_commit.style = "bold purple";
      # $tag
      git_commit.tag_disabled = false;
      git_commit.tag_symbol = "";

      git_state.format = " [\\($state\\)]($style)";
      git_state.style = "bold purple";

      # git_status.format = "( \\[[$all_status$ahead_behind]($style)\\])";
      # git_status.format = "[(  $count$conflicted$deleted$modified$renamed$staged$untracked)( STASHED$stashed)($ahead_behind)]($style)";
      # git_status.format = "[(  $count$conflicted$deleted$modified$renamed$staged$untracked)]($style)";

      git_status.format = " [\\[$conflicted$deleted$modified$renamed$staged$untracked\\]]($style)";
      git_status.style = "bold purple";
      # $conflicted$deleted$modified$renamed$staged$untracked
      git_status.conflicted = "*";
      git_status.deleted = "-";
      git_status.modified = "~";
      git_status.renamed = "/";
      git_status.staged = "+";
      git_status.untracked = "?";
      # $stashed
      git_status.stashed = "";

      direnv.disabled = false;
      direnv.format = " [$loaded]($style)( [$allowed]($style))";
      direnv.style = "bold yellow";
      # $allowed
      direnv.allowed_msg = "";
      direnv.denied_msg = "denied";
      direnv.not_allowed_msg = "not allowed";
      # $loaded
      direnv.loaded_msg = " ";
      direnv.unloaded_msg = " ";

      nix_shell.format = " [$symbol]($style)";
      nix_shell.style = "bold blue";
      nix_shell.symbol = " ";

      shlvl.format = " [ $shlvl]($style)";
      shlvl.style = "bold red";

      jobs.format = " [$symbol$number]($style)";
      jobs.style = "bold blue";
      jobs.symbol = " ";

      status.disabled = false;
      status.format = " [$symbol$status]($style)";

      cmd_duration.format = " [ $duration]($style)";
      cmd_duration.style = "bold yellow";
    };
  };
}
