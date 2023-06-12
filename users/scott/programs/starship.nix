{lib, ...}: {
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      command_timeout = 200;

      # scott-desktop as scott in ~ on main at 3cae0f8d
      # ^^^^^^^^^^^^^    ^^^^^    ^    ^^^^    ^^^^^^^^

      format = lib.concatStrings [
        "($hostname (\\($localip\\) )as )"
        "($username in )"
        "$directory"
        "( \\($container$nix_shell\\))"
        "( on $git_branch)( at $git_commit)( \\($git_status\\))( \\[$git_state\\])"
        "( with $package)"
        "( \\($nodejs$rust\\))"
        "( took $cmd_duration)"
        "$line_break"
        "(\\($jobs\\) )$character"
      ];

      hostname = {
        format = "[$hostname]($style)";
        ssh_only = false;
        style = "bold bright-purple";
        trim_at = ".";
      };

      localip = {
        disabled = false;
        format = "[$localipv4]($style)";
        style = "bright-purple";
      };

      username = {
        format = "[$user]($style)";
        show_always = true;
        style_user = "bold bright-blue";
      };

      container = {
        format = "[$symbol $name]($style)";
        style = "bright-cyan";
        symbol = "container";
      };

      nix_shell = {
        format = "[$symbol $name]($style)";
        style = "bright-cyan";
        symbol = "nix";
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style)";
        read_only = "*";
        read_only_style = "bold bright-red";
        repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style)";
        style = "bold bright-cyan";
        truncation_symbol = "...";
      };

      git_branch = {
        format = "[$branch(:$remote_branch)]($style)";
        style = "bold bright-green";
      };

      git_commit = {
        format = "[$hash(, $tag)]($style)";
        style = "bold bright-green";
        tag_disabled = false;
        tag_symbol = "";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        style = "bright-green";
      };

      git_state = {
        am = "apply mailbox";
        am_or_rebase = "apply mailbox/rebase";
        bisect = "bisect";
        cherry_pick = "cherry pick";
        format = "[$state( $progress_current/$progress_total)]($style)";
        merge = "merge";
        rebase = "rebase";
        revert = "revert";
        style = "bright-green";
      };

      package = {
        format = "[$version]($style)";
        style = "bold bright-yellow";
      };

      nodejs = {
        format = "[$symbol( $version)]($style)";
        not_capable_style = "bright-red";
        style = "bright-yellow";
        symbol = "node";
      };

      rust = {
        format = "[$symbol( $version)]($style)";
        style = "bright-yellow";
        symbol = "rust";
      };

      cmd_duration = {
        format = "[$duration]($style)";
        min_time = 1000;
        style = "bright-red";
      };

      jobs = {
        format = "[$number]($style)";
        number_threshold = 1;
        style = "bright-red";
      };

      character = {
        error_symbol = "[❯](bold bright-red)";
        success_symbol = "[❯](bold)";
      };
    };
  };
}
