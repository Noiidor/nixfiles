{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./tmpfiles.nix
    ../base.nix
    ../../scripts/scripts.nix

    inputs.aagl.nixosModules.default
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [
      "nct6775"
      "i2c-dev"
      "msr"
    ];

    extraModprobeConfig = ''
      options hid_apple fnmode=0
    '';
  };

  networking = {
    hostName = "pc";
    networkmanager = {
      enable = true;
      wifi.powersave = false; # Unstable connectivity without this
      logLevel = "DEBUG";
    };
    extraHosts = ''
      130.255.77.28 ntc.party
    '';
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
    };
    proxy = {
      default = "http://router.local:8118";
      allProxy = "http://router.local:8118";
      httpProxy = "http://router.local:8118";
      httpsProxy = "http://router.local:8118";
    };
  };

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  users.users."noi" = {
    isNormalUser = true;
    description = "noi";
    extraGroups = ["networkmanager" "wheel"];
  };

  environment.systemPackages = with pkgs; [
    # CLI utils
    usbutils
    inetutils
    pciutils
    ddcutil

    # System
    home-manager
    wirelesstools
    wl-clipboard
    wireguard-tools
    zenmonitor
    btop

    # Disks and FS
    gparted
    ntfs3g
    testdisk
    adbfs-rootless
    android-tools
    simple-mtpfs
    qdiskinfo # Disk health GUI
    kdiskmark
    unrar

    # Auth and security
    yubioath-flutter
    picotool

    # Network

    # Lib
    libadwaita
    libnotify

    # Media
    unstable.yazi
    dragon-drop # Drag-n-drop utility
    hexyl # Hex binary viewer
    qimgv
    # unstable.gimp3
    # scribus
    mpv
    qbittorrent

    # Terminal
    zsh
    foot
    starship
    zoxide
    nvimpager

    # Desktop
    unstable.telegram-desktop

    #=== Applications and gaming
    # vesktop
    (unstable.bottles.override {removeWarningPopup = true;})

    # Programming
    graphviz
    delta # better git pager
    zls
    zig
    unstable.python3
    unstable.go
    delve # go

    #=== Rust
    rustc
    cargo

    #=== C/C++
    llvmPackages_20.clang-tools
    gcc
    #=== Typst
    typst
    typstyle
    tinymist

    # LSP
    nil # nix
    nixd
    lua-language-server
    postgres-language-server
    sqls
    pyright
    docker-compose-language-service
    dockerfile-language-server
    yaml-language-server
    rust-analyzer
    # unstable.ols
    gopls

    # Formatting
    stylua # lua
    sleek # sql
    sql-formatter
    rustfmt
    sqlfluff
    kdlfmt

    # Other
    taskwarrior3
    agenix

    # Media
    zen-browser
    obsidian

    # Gaming
    freesm-launcher

    # Music
    unstable.tauon

    # LLM
    llmPkgs.claude-code
    llmPkgs.claude-code-router
    llmPkgs.opencode
  ];

  environment.variables = {
    EDITOR = "nvim";
    PSQL_PAGER = "pspg -X -s 1";
  };

  programs.coolercontrol.enable = true;

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 6;
    enableNotifications = true;
  };

  programs = {
    wireshark = {
      enable = true;
      dumpcap.enable = true;
      usbmon.enable = true;
    };
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  #=== Virtualization and containerization
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  fonts.packages = with pkgs; [
    # terminus_font
    maple-mono.NF-CN
    zpix-pixel-font
    (callPackage ../../pkgs/vcr-osd-cyr-font/vcr-osd-cyr-font.nix {})
  ];

  programs = {
    direnv = {
      enable = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamemode.enable = true;
    gamescope = {
      enable = true;
      package = pkgs.unstable.gamescope;
    };

    git = {
      enable = true;
      config = {
        core = {
          pager = "delta";
        };
        user = {
          name = "noi";
          email = "noidor2019@gmail.com";
        };
        init.defaultBranch = "master";

        pull = {
          rebase = true;
        };
        merge = {
          conflictStyle = "zdiff3";
        };
        interactive = {
          diffFilter = "delta --color-only";
        };
        delta = {
          navigate = true;
          dark = true;
        };
        alias = {
          sdiff = "-c delta.features=side-by-side diff";
        };

        url = {
          "git@gitlab.com:" = {
            insteadOf = [
              "https://gitlab.com/"
            ];
          };
          "git@github.com:" = {
            insteadOf = [
              "https://github.com/"
            ];
          };
        };
      };
    };
  };

  programs = {
    honkers-railway-launcher.enable = true;
    sleepy-launcher.enable = true;
  };

  #=== Nix
  programs.nh = {
    enable = true;
    flake = "/home/noi/nixfiles";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 5d --keep 5";
    };
  };

  nix = {
    settings = {
      fallback = true;
      keep-going = true;

      http-connections = 128;
      max-substitution-jobs = 128;
      stalled-download-timeout = 4;
      connect-timeout = 8;

      substituters = [
        # "https://hyprland.cachix.org"

        "https://mirror.yandex.ru/nixos?priority=1"
        "https://cache.nixos.org?priority=2"
        # "https://cache.xd0.zip"
        # "https://cache.nixos.kz"
        # "https://nixos-cache-proxy.cofob.dev"
        # "https://nixos-cache-proxy.sweetdogs.ru"
        # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

        # "https://nix-community.cachix.org"
        "https://attic.xuyh0120.win/lantian?priority=100"
        # "https://cache.garnix.io?priority=110"
        "https://kopuz.cachix.org?priority=201" # kopuz player
        "https://ezkea.cachix.org?priority=201" # aagl pkgs
      ];
      trusted-public-keys = [
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "kopuz.cachix.org-1:J2X3AnAYhKTJW5S3aCLoA1ckonQXVNZMQvhZA0YAufw="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      ];

      cores = 8;
      max-jobs = 4;
    };
    # // inputs.aagl.nixConfig;

    optimise = {
      automatic = true;
      persistent = true;
      dates = ["Fri 23:00"];
    };

    # gc = {
    #   dates = "daily";
    #   options = "--delete-older-than 7d";
    # };
  };

  systemd.services.nix-daemon.environment = {
    # http_proxy = "http://router.local:8118";
    # https_proxy = "http://router.local:8118";
  };

  system.stateVersion = "26.05";
}
