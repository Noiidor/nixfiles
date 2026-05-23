{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../modules/home-manager/stylix/stylix.nix
    ../modules/home-manager/spicetify/spicetify.nix
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
        # clickhouse-cli
        # go-migrate
        kubectl
        protobuf
        gnumake
        gdb # GNU debugger
        # kubernetes-helm

        #=== Haskell
        # haskell.compiler.ghcHEAD

        qbittorrent
        obsidian
        mangohud
        # piper
        # bitwarden-desktop
        # unstable.keyguard
        # lutris
        links2 # Terminal web browser
        # kando # GUI pie-picker
        # qutebrowser
        # unstable.winetricks
        # unstable.wineWowPackages.waylandFull
        # lutris

        # Media
        # inkscape
        obs-studio
        mesa-demos
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
        # davinci-resolve
        gnome-font-viewer
        unstable.wiremix
        wl-screenrec
        # weasis # DICOM viewer
        # eaglemode # absolute cinema

        #=== Network
        iperf3
        tcpdump
        nmap # Network security and port scanner
        dig # DNS lookup
        mtr # ping + traceroute
        trippy # ping + traceroute TUI
        posting # TUI HTTP Client

        #=== Disks and filesystem
        # iozone
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
        linux-manual
        man-pages
        nix-visualize
        wf-recorder # Screen recorder
        # espeak
        memtester # RAM tester
        file
        zip
        trash-cli
        udiskie
        smartmontools
        caligula
        unstable.sequin # Decode ANSI sequences

        xorg.xprop # x11/xwayland debug info
        xorg.xlsclients
      ])
      # Other
      ++ [
        # inputs.aagl.packages.${pkgs.system}.the-honkers-railway-launcher
        # inputs.aagl.packages.${pkgs.system}.sleepy-launcher
      ];

    sessionPath = [
    ];

    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      PAGER = "nvimpager";
    };

    stateVersion = "25.11";
  };

  programs = {
    mpv = {
      enable = true;
      scripts = [pkgs.mpvScripts.uosc];
      config = {
        loop-file = "inf";
      };
    };

    wofi = {
      enable = false;
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
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
      ];
      qimgv = ["image/png" "image/jpeg" "image/webp" "image/gif"];
    };
  in
    {
      "inode/directory" = "org.gnome.Nautilus.desktop";
    }
    // (lib.genAttrs apps.mpv (_: "mpv.desktop"))
    // (lib.genAttrs apps.nvim (_: "nvim.desktop"))
    // (lib.genAttrs apps.zen (_: "zen-beta.desktop"))
    // (lib.genAttrs apps.qimgv (_: "qimgv.desktop"));
}
