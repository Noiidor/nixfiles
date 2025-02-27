{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  imports = [
    ./modules/nvim/nvim.nix
    ./modules/tmux/tmux.nix
    ./modules/zsh/zsh.nix
    ./modules/stylix/stylix.nix
    ./modules/flatpak/flatpak.nix
    ./modules/spicetify/spicetify.nix
    ./modules/ghostty/ghostty.nix
    # ./modules/themes/default.nix
  ];

  home = {
    username = "noi";
    homeDirectory = "/home/noi";

    packages =
      # Stable packages
      (with pkgs; [
        # Programming
        bruno
        dbeaver-bin
        graphviz
        clickhouse-cli
        go-migrate
        goose
        natscli
        nats-top
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

        # Dotnet
        dotnet-runtime

        # Applications and gaming
        vesktop
        telegram-desktop
        qbittorrent
        obsidian
        bottles
        mangohud
        zoom-us
        piper
        baobab # Disk usage analyzer
        bitwarden-desktop
        bitwarden-cli
        keyguard
        mullvad-vpn
        mullvad-closest
        lutris

        # Media
        yazi # File manager
        gimp
        inkscape
        obs-studio
        glxinfo
        scribus
        libreoffice-fresh
        feh # image viewer
        shotcut # video editing
        unrar
        kdePackages.ark # Acrhiever

        # TUI
        lazygit
        lazydocker
        pspg
        pgcli
        mods # LLM frontend
        wishlist # SSH picker

        # CLI utils
        fastfetch
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
        qrencode
        nmap
        hollywood
        charm-freeze # Generate terminal images
        vhs # Generate terminal GIFs
        glow # Render markdown in terminal
        xcur2png
        tldr
        viddy
        yt-dlp # video downloader

        # Other
        kdePackages.qt6ct
      ])
      # Unstable packages
      ++ (with pkgs-unstable; [
        # Work

        # Applications and gaming
        wineWowPackages.waylandFull
        winetricks

        # Media

        # TUI
        claude-code

        # CLI utils
        astroterm
        sequin # Decode ANSI sequences
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

    # pointerCursor = let
    #   variants = ["Firefly" "Furina-v2" "Monika"];
    #   customCursors = pkgs.stdenv.mkDerivation {
    #     name = "customCursor";
    #     src = pkgs.fetchzip {
    #       url = "https://github.com/Noiidor/cursors/archive/195efaf341d2f615fb8717e79acee1b213e0bf23.tar.gz";
    #       sha256 = "10kkxn7jxgszc4ms0262zx2714jf3p5vy5n5z4baqksz55nzwknh";
    #     };
    #     installPhase = ''
    #       for theme in $variants; do
    #         mkdir -p $out/share/icons/$theme
    #         cp -R $src/$theme/{cursors,index.theme} $out/share/icons/$theme/
    #       done
    #     '';
    #   };
    # in
    #   lib.mkForce {
    #     gtk.enable = true;
    #     x11.enable = true;
    #     name = "Furina-v2";
    #     size = cursorSize;
    #     package = customCursors;
    #   };

    stateVersion = "24.11";
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "hyprland;gtk";
  };

  programs = {
    kitty = {
      enable = true;
      package = pkgs-unstable.kitty;
    };
    zoxide.enable = true;

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

    wofi = {
      enable = true;
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

    "application/x-extension-htm" = "zen.desktop";
    "application/x-extension-html" = "zen.desktop";
    "application/x-extension-shtml" = "zen.desktop";
    "application/x-extension-xht" = "zen.desktop";
    "application/x-extension-xhtml" = "zen.desktop";
    "x-scheme-handler/chrome" = "zen.desktop";
    "x-scheme-handler/http" = "zen.desktop";
    "x-scheme-handler/https" = "zen.desktop";
    "application/xhtml+xml" = "zen.desktop";
    "application/pdf" = "zen.desktop";
  };

  nixpkgs.config.allowUnfree = true;
}
