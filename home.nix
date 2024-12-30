{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  imports = [
    ./modules/nvim/nvim.nix
    ./modules/tmux/tmux.nix
    ./modules/zsh/zsh.nix
    # ./modules/stylix/stylix.nix
    ./modules/flatpak/flatpak.nix
    ./modules/spicetify/spicetify.nix
    ./modules/ghostty/ghostty.nix
  ];

  home = {
    username = "noi";
    homeDirectory = "/home/noi";

    packages =
      # Stable packages
      (with pkgs; [
        # Programming
        bruno
        vscode
        postman
        dbeaver-bin
        graphviz
        clickhouse
        go-migrate
        goose
        natscli
        nats-top
        pgcli
        glab

        # Golang
        go
        gopls
        go-tools
        gotools
        grpc-gateway
        protoc-gen-go
        protoc-gen-go-grpc
        protoc-gen-connect-go
        protoc-gen-validate
        protoc-gen-doc
        golangci-lint

        # OdinLang
        odin
        ols

        # Applications and gaming
        vesktop
        lutris
        telegram-desktop
        qbittorrent
        obsidian
        bottles
        mangohud
        zoom-us
        piper
        baobab # Disk usage analyzer

        # Media
        yazi # File manager
        gimp
        inkscape
        obs-studio
        glxinfo
        scribus
        libreoffice-fresh
        yt-dlp # video downloader
        feh # image viewer
        shotcut # video editing
        unrar

        # TUI
        lazygit
        lazydocker
        pspg

        # CLI utils
        cbonsai
        lux
        cava
        eza
        bat
        sl
        cmatrix
        aalib
        fzf
        wev # wayland actions
      ])
      # Unstable packages
      ++ (with pkgs-unstable; [
        # Work

        # Applications and gaming

        # Media

        # TUI

        # CLI utils
        buf
      ])
      # Other
      ++ [
        inputs.aagl.packages.${pkgs.system}.the-honkers-railway-launcher
        inputs.zen-browser.packages.${pkgs.system}.default
      ];

    sessionPath = [
      "$HOME/nixfiles/scripts"
      "$HOME/go/bin"
    ];

    sessionVariables = {
      PSQL_PAGER = "pspg -X -s 1";

      # Not sure if its essensial
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
      CLUTTER_BACKEND = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    stateVersion = "24.11";
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };

  # programs = let
  #   spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  # in
  programs = {
    kitty = {
      enable = true;
      package = pkgs-unstable.kitty;
    };
    zoxide.enable = true;

    firefox.enable = true;

    # spicetify = {
    #   enable = true;
    #   enabledExtensions = with spicePkgs.extensions; [
    #     adblock
    #     hidePodcasts
    #     copyToClipboard
    #     autoSkip
    #     fullAppDisplay
    #     keyboardShortcut
    #     songStats
    #   ];
    #   enabledCustomApps = with spicePkgs.apps; [
    #     ncsVisualizer
    #     lyricsPlus
    #   ];
    #   # theme = spicePkgs.themes.comfy;
    #   colorScheme = "hikari";
    # };

    mpv = {
      enable = true;
      scripts = [pkgs.mpvScripts.uosc];
      config = {
        loop-file = "inf";
      };
    };

    imv = {
      enable = true;
    };

    htop = {
      enable = true;
      settings = {
        tree_view = 1;
      };
    };

    btop.enable = true;

    git = {
      enable = true;
      userName = "noi";
      userEmail = "noidor2019@gmail.com";
      extraConfig = {
        init.defaultBranch = "master";

        pull = {
          rebase = true;
        };

        url = {
          "git@gitlab.com:" = {
            insteadOf = [
              "https://gitlab.com/"
            ];
          };
        };
      };
    };

    home-manager.enable = true;
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "image/png" = "imv.desktop";
    "image/jpeg" = "imv.desktop";
    "image/webp" = "imv.desktop";
    "image/gif" = "mpv.desktop";
    "video/mp4" = "mpv.desktop";
    "video/mpeg" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
    "video/mkv" = "mpv.desktop";
    "video/quicktime" = "mpv.desktop";

    "inode/directory" = "org.gnome.Nautilus.desktop";

    "text/plain" = "nvim.desktop";
    "text/html" = "nvim.desktop";
    "text/markdown" = "nvim.desktop";
    "application/json" = "nvim.desktop";

    "application/pdf" = "firefox.desktop";
    "application/epub+zip" = "firefox.desktop";
    "application/x-extension-htm" = "firefox.desktop";
    "application/x-extension-html" = "firefox.desktop";
    "application/x-extension-shtml" = "firefox.desktop";
    "application/x-extension-xht" = "firefox.desktop";
    "application/x-extension-xhtml" = "firefox.desktop";
    "application/x-extension-xhtml+xml" = "firefox.desktop";
    "x-scheme-handler/chrome" = "firefox.desktop";
    "x-scheme-handler/ftp" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };

  nixpkgs.config.allowUnfree = true;
}
