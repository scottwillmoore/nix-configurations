{ ... }:
{
  colorschemes = {
    tokyonight.enable = true;
    tokyonight = {
      settings = {
        light_style = "day";
        style = "night";
      };
    };
  };

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  opts = {
    cmdheight = 0;
    cursorline = true;
    ignorecase = true;
    laststatus = 3;
    list = true;
    number = true;
    relativenumber = true;
    scrolloff = 4;
    showmode = false;
    sidescrolloff = 4;
    signcolumn = "yes";
    smartcase = true;
    splitbelow = true;
    splitright = true;
    timeoutlen = 200;
    undofile = true;
    updatetime = 250;

    # autoindent = true;
    # smartindent = false;
  };

  plugins = {
    cmp.enable = true;
    cmp-buffer.enable = true;
    cmp-cmdline.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lua.enable = true;
    cmp-path.enable = true;

    conform-nvim.enable = true;
    conform-nvim.settings = {
      format_on_save = {
        lsp_format = "fallback";
      };
    };

    # fidget.enable = true;

    gitsigns.enable = true;

    guess-indent.enable = true;
    guess-indent = {
      autoLoad = true;
    };

    # indent-blankline.enable = true;

    lualine.enable = true;
    lualine = {
      settings = {
        options = {
          always_divide_middle = true;
          component_separators = "";
          icons_enabled = false;
          section_separators = "";
        };
      };
    };

    lsp.enable = true;
    lsp = {
      inlayHints = true;
      servers = {
        nixd.enable = true;
      };
    };

    mini.enable = true;
    mini = {
      mockDevIcons = true;

      modules = {
        ai = { };

        comment = { };

        icons = {
          style = "ascii";
        };

        surround = { };
      };
    };

    oil.enable = true;

    telescope.enable = true;
    telescope = {
      extensions = {
        fzf-native.enable = true;
      };
    };

    treesitter.enable = true;
    treesitter = {
      settings = {
        highlight.enable = true;
        # indent.enable = true;
      };
    };

    which-key.enable = true;
    which-key = {
      settings = {
        icons.mappings = false;
      };
    };
  };

  vimAlias = true;
}
