{
  vars,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];
  stylix = {
    enable = true;
    autoEnable = true;
    image = ./wallpaper.jpg;
    polarity = "dark";
    base16Scheme = {
      base00 = "1b100f";
      base01 = "2e1d1d";
      base02 = "6b3844";
      base03 = "da7890";
      base04 = "805a5a";
      base05 = "a87d7d";
      base06 = "c4adad";
      base07 = "e8e1e1";
      base08 = "f8d8d8";
      base09 = "cddafc";
      base0A = "a19552";
      base0B = "f1b9eb";
      base0C = "ffacd0";
      base0D = "5ac670";
      base0E = "c3d2f6";
      base0F = "c1b492";
      author = "Me";
      scheme = "Wired";
      slug = "wired";
    };

    targets = {
      neovim.enable = true;
      neovim.plugin = "base16-nvim";
      hyprland.enable = false;
    };

    cursor = {
      package = pkgs.graphite-cursors;
      name = "graphite-light-nord";
      size = 26;
    };

    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF-CN;
        # package = pkgs.zpix-pixel-font;
        # package = inputs.kirsch-font.packages.${pkgs.system}.kirsch-nerd;
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
        popups = 12;
        terminal = 16;
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
