{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  # Stable user packages
  home.packages = with pkgs; [
    fd
    ripgrep
    nil
    stylua
    lua-language-server
    postgres-lsp
    sqls
    sleek
  ];

  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    # Stable nvim plugins
    plugins =
      (with pkgs.vimPlugins; [
        # General
        vim-sleuth
        which-key-nvim
        plenary-nvim
        nvim-web-devicons

        #Git
        gitsigns-nvim

        # Telescope
        telescope-nvim
        telescope-ui-select-nvim
        telescope-fzf-native-nvim
        telescope-file-browser-nvim

        # LSP and snippets
        nvim-lspconfig
        nvim-cmp
        cmp_luasnip
        cmp-nvim-lsp
        cmp-nvim-lua
        cmp-buffer
        cmp-path
        luasnip

        # Format
        conform-nvim

        # Visual
        tokyonight-nvim
        cyberdream-nvim
        kanagawa-nvim
        onedark-nvim
        onedarker-nvim
        miasma-nvim
        nightfox-nvim
        twilight-nvim
        alpha-nvim
        todo-comments-nvim
        fidget-nvim

        # Utils
        mini-nvim
        vim-tmux-navigator
      ])
      ++
      # Unstable nvim plugins
      (with pkgs-unstable.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ]);
  };

  xdg.configFile.nvim = {
    recursive = true;
    source = ./.;
  };
}
