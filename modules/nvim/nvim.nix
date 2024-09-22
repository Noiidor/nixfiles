{config, pkgs, pkgs-unstable, ...}: 

{
  # Stable user packages
  home.packages = (with pkgs; [
    fd
    ripgrep
    nil
    stylua
    lua-language-server
  ]);

  programs.neovim = {
      enable = true;
      package = pkgs-unstable.neovim-unwrapped;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      # Stable nvim plugins
      plugins = (with pkgs.vimPlugins; [
	telescope-nvim
	vim-sleuth
	gitsigns-nvim
	which-key-nvim
	plenary-nvim
	telescope-ui-select-nvim
	telescope-fzf-native-nvim
	nvim-web-devicons

	nvim-lspconfig
        nvim-cmp
	luasnip
	cmp_luasnip
	cmp-nvim-lsp
	cmp-path
	conform-nvim

	tokyonight-nvim

	todo-comments-nvim
	mini-nvim
	fidget-nvim
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
