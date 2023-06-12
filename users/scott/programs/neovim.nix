{packages, ...}: {
  programs.neovim = {
    enable = true;

    defaultEditor = true;

    plugins = with packages.vimPlugins; [
      vim-nix
    ];

    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set cursorline
      set foldopen=mark,search,tag,undo
      set list
      set listchars="extends:›,precedes:‹,nbsp:·,tab:»\ ,trail:·"
      set mouse=a
      set nohlsearch
      set noswapfile
      set nowrap
      set number
      set ruler
      set scrolloff=4
      set shiftwidth=4
      set sidescrolloff=4
      set noshowmode
      set smartindent
      set softtabstop=4
      set spelllang=en_au,en_gb
      set splitbelow
      set splitright
      set tabstop=4
      set undofile
    '';
  };
}
