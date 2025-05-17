{
  vars,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];
  stylix = {
    enable = true;
    autoEnable = true;
    image = ./wallpaper.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/hardcore.yaml";

    cursor = {
      package = pkgs.graphite-cursors;
      name = "graphite-light-nord";
      size = 26;
    };

    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF-CN;
        name = vars.fontName;
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      # emoji = {
      #   package = pkgs.maple-mono.;
      #   name = vars.fontName;
      # };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
  };
}
