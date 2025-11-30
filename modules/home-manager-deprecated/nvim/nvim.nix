{
  pkgs,
  # pkgs-unstable,
  ...
}: {
  # Stable user packages
  home.packages = with pkgs; [
    fd
    ripgrep
    nvimpager

    # Format
    stylua # lua
    biome # json, js
    sleek # sql
    sql-formatter
    yamlfmt
    rustfmt
    sqlfluff
    kdlfmt

    # LSP
    nil # nix
    nixd
    lua-language-server
    postgres-lsp
    sqls
    pyright
    docker-compose-language-service
    dockerfile-language-server-nodejs
    yaml-language-server
    rust-analyzer
    unstable.ols

    # Debug
    python312Packages.debugpy
    delve # go
  ];

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    PAGER = "nvimpager";
  };

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    plugins =
      (with pkgs.vimPlugins; [
        # General
        vim-sleuth
        which-key-nvim
        plenary-nvim
        nvim-web-devicons
        nvim-autopairs

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

        # Debugging
        nvim-dap
        nvim-dap-go
        nvim-dap-python
        nvim-dap-ui
        nvim-dap-virtual-text

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
        base16-nvim
        vim-illuminate

        # Utils
        mini-nvim
        vim-tmux-navigator
        better-escape-nvim
        hardtime-nvim
        typst-preview-nvim
      ])
      ++
      # Unstable nvim plugins
      (with pkgs.unstable.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ]);
  };

  xdg.configFile.nvim = {
    recursive = true;
    source = ./.;
  };
}
