{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./modules/home-manager-deprecated/nvim/nvim.nix
    # ./modules/home-manager-deprecated/zsh/zsh.nix
    ./modules/home-manager-deprecated/stylix/stylix.nix
    ./modules/home-manager-deprecated/spicetify/spicetify.nix
  ];

  home = {
    username = "noi";
    homeDirectory = "/home/noi";

    packages =
      # Stable packages
      (with pkgs; [
        #=== Programming
        # bruno
        # dbeaver-bin
        graphviz
        # clickhouse-cli
        # go-migrate
        kubectl
        protobuf
        gnumake
        gdb # GNU debugger
        # kubernetes-helm
        sentry-cli
        gcc

        #=== Golang
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

        #=== Odin
        unstable.odin
        unstable.ols

        #=== Python
        python3

        #=== Dotnet
        # dotnet-runtime

        #=== Julia
        julia

        #=== Rust
        rustc
        cargo
        cargo-modules # tree of project modules
        cargo-bloat

        #=== C/C++
        # llvmPackages_20.clang
        llvmPackages_20.clang-tools

        #=== Haskell
        # haskell.compiler.ghcHEAD

        #=== Typst
        typst
        typstyle
        tinymist

        #=== Applications and gaming
        vesktop
        qbittorrent
        obsidian
        (bottles.override {removeWarningPopup = true;})
        mangohud
        # piper
        # bitwarden-desktop
        bitwarden-cli
        # unstable.keyguard
        mullvad-vpn
        mullvad-closest
        # lutris
        links2 # Terminal web browser
        # kando # GUI pie-picker
        # qutebrowser
        unstable.ayugram-desktop
        # unstable.winetricks
        # unstable.wineWowPackages.waylandFull

        # Media
        unstable.gimp3
        # inkscape
        obs-studio
        mesa-demos
        scribus
        libreoffice-fresh
        unrar
        kdePackages.ark # Acrhiever
        pinta
        zathura # PDF viewer
        # nemo # Cinnamon file manager
        # xfce.thunar # Xfce file manager
        unzip
        ffmpeg
        rnote
        davinci-resolve
        gnome-font-viewer
        unstable.wiremix
        wl-screenrec
        # weasis # DICOM viewer
        # eaglemode # absolute cinema

        #=== Network
        iperf3
        tcpdump
        nmap # Network security and port scanner
        gping
        dig # DNS lookup
        mtr # ping + traceroute
        trippy # ping + traceroute TUI
        posting # TUI HTTP Client

        #=== Disks and filesystem
        iozone
        baobab # Disk usage analyzer
        # duf # Good looking df alternatinve
        # phoronix-test-suite # Comprehensive system benchmark
        fio # IO Benchmark

        #=== Bluetooth
        blueman
        bluetuith

        #=== LLM
        # mods # TUI frontend

        #=== TUI
        lazygit
        lazydocker
        pspg
        pgcli
        wishlist # SSH picker
        nix-tree # Nix pkgs dependencies and size
        # smassh # TUI MonkeyType

        #=== Monitoring
        s-tui # Stress-test
        atop # Detailed system metrics
        iftop # Network bandwith usage
        iotop # I/O metrics
        # sysdig
        nvtopPackages.amd # GPU metrics
        wavemon # WiFi metrics
        # glances
        # mission-center # GUI system monitor
        # lazysql
        # lazyjournal

        #=== CLI utils
        fastfetch
        cbonsai
        # lux # Video downloader
        cava
        eza
        bat
        cmatrix
        fzf
        wev # wayland actions
        qrencode
        charm-freeze # Generate terminal images
        vhs # Generate terminal GIFs
        glow # Render markdown in terminal
        tldr # Short manual
        viddy
        unstable.yt-dlp # video downloader
        jq
        yq
        alejandra
        linux-manual
        man-pages
        nix-visualize
        wf-recorder # Screen recorder
        ripgrep
        # espeak
        memtester # RAM tester
        rsync
        file
        zip
        trash-cli
        udiskie
        smartmontools
        caligula
        # unstable.astroterm
        unstable.sequin # Decode ANSI sequences
        unstable.buf
        unstable.spotdl # Download music from yt/spotify

        xorg.xprop # x11/xwayland debug info
        xorg.xlsclients
      ])
      # Other
      ++ [
        inputs.aagl.packages.${pkgs.system}.the-honkers-railway-launcher
        # inputs.aagl.packages.${pkgs.system}.sleepy-launcher
        inputs.zen-browser2.packages.${pkgs.system}.default
      ];

    sessionPath = [
    ];

    sessionVariables = {
      EDITOR = "nvim";
      # WLR_NO_HARDWARE_CURSORS = "1";
    };

    stateVersion = "25.11";
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

    home-manager = {
      enable = true;
    };
  };

  services = {
    mpris-proxy.enable = true; # Bluetooth devices media buttons
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
