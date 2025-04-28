{
  user,
  pkgs,
  inputs,
  lib,
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
    ./modules/hyprpanel/hyprpanel.nix
    ./modules/qimgv/qimgv.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";

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
        kubectl
        kubectx
        protobuf_26
        gcc
        helix

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

        # Odin
        unstable.odin
        unstable.ols

        # Python
        python3

        # Dotnet
        dotnet-runtime

        # Julia
        julia

        # Rust
        rustc
        cargo
        cargo-modules # tree of project modules

        # System

        # Applications and gaming
        vesktop
        qbittorrent
        obsidian
        bottles
        mangohud
        zoom-us
        piper
        baobab # Disk usage analyzer
        # bitwarden-desktop
        bitwarden-cli
        unstable.keyguard
        mullvad-vpn
        mullvad-closest
        lutris
        ventoy
        links2 # Terminal web browser
        # kando # GUI pie-picker

        unstable.ayugram-desktop
        unstable.winetricks
        unstable.wineWowPackages.waylandFull

        # Media
        yazi # File manager
        unstable.gimp3
        inkscape
        obs-studio
        glxinfo
        scribus
        libreoffice-fresh
        shotcut # video editing
        unrar
        kdePackages.ark # Acrhiever
        pinta

        # TUI
        lazygit
        lazydocker
        pspg
        pgcli
        mods # LLM frontend
        wishlist # SSH picker
        nix-tree

        unstable.claude-code

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
        jq
        yq
        alejandra
        linux-manual
        man-pages
        nix-visualize
        wf-recorder # Screen recorder
        ripgrep
        thefuck

        unstable.astroterm
        unstable.sequin # Decode ANSI sequences
        unstable.buf
        unstable.spotdl # Download music from yt/spotify

        # Other
        kdePackages.qt6ct
      ])
      # Other
      ++ [
        inputs.aagl.packages.${pkgs.system}.the-honkers-railway-launcher
        inputs.aagl.packages.${pkgs.system}.sleepy-launcher
        inputs.zen-browser.packages.${pkgs.system}.default
      ];

    sessionPath = [
    ];

    sessionVariables = {
      PSQL_PAGER = "pspg -X -s 1";

      # Not sure if its essensial
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_QPA_PLATFORMTHEME = "gtk3"; # Fixes Telegram file picker
      CLUTTER_BACKEND = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    stateVersion = "24.11";
  };

  programs = {
    zoxide.enable = true;

    mpv = {
      enable = true;
      scripts = [pkgs.mpvScripts.uosc];
      config = {
        loop-file = "inf";
      };
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

    home-manager = {
      enable = true;
    };
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = let
    apps = {
      mpv = [
        "video/mp4"
        "video/mpeg"
        "video/webm"
        "video/mkv"
        "video/quicktime"
      ];
      nvim = [
        "text/plain"
        "text/html"
        "text/markdown"
        "application/json"
      ];
      zen = [
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/x-extension-xht"
        "application/x-extension-xhtml"
        "x-scheme-handler/chrome"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "application/xhtml+xml"
        "application/pdf"
      ];
    };
  in
    {
      "inode/directory" = "org.gnome.Nautilus.desktop";
    }
    // (lib.genAttrs apps.mpv (_: "mpv.desktop"))
    // (lib.genAttrs apps.nvim (_: "nvim.desktop"))
    // (lib.genAttrs apps.zen (_: "zen.desktop"));
}
