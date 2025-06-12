{pkgs, ...}: {
  home.packages = with pkgs; [
    dragon-drop
    hexyl
  ];
  programs = {
    yazi = {
      enable = true;
      package = pkgs.unstable.yazi;
      enableZshIntegration = true;
      shellWrapperName = "yz";
      plugins = {
        glow = pkgs.yaziPlugins.glow;
        full-border = pkgs.yaziPlugins.full-border;
      };
      # settings = {
      #   mgr = {
      #     show_hidden = true;
      #     sort_by = "mtime";
      #     sort_reverse = true;
      #   };
      #   plugin = {
      #     prepend_previewers = [
      #       {
      #         name = "*.md";
      #         run = "glow";
      #       }
      #     ];
      #   };
      # };
      # keymap = {
      #   mgr = {
      #     prepend_keymap = [
      #       {
      #         on = "<C-n>";
      #         run = ''shell 'dragon-drop -x -i -T "$@"' '';
      #       }
      #     ];
      #   };
      # };
    };
  };
}
