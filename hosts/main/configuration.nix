{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./tmpfiles.nix
    ../base.nix
    ../../scripts/scripts.nix

    inputs.aagl.nixosModules.default
    inputs.spicetify-nix.nixosModules.spicetify
    inputs.selector4nix.nixosModules.default
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    # CLI utilities
    usbutils
    inetutils
    pciutils
    ddcutil
    hexyl # Hex binary viewer
    taskwarrior3

    # System
    home-manager
    wl-clipboard

    # Monitoring
    zenmonitor
    btop
    lact
    furmark

    # Disks and filesystems
    gparted
    ntfs3g
    testdisk
    adbfs-rootless
    android-tools
    simple-mtpfs
    qdiskinfo # Disk health GUI
    kdiskmark
    unrar
    unstable.yazi
    dragon-drop # Drag-n-drop utility

    # Networking
    wirelesstools
    wireguard-tools

    # Authentication and security
    yubioath-flutter
    agenix
    firejail

    # Libraries
    libadwaita
    libnotify
    ocl-icd
    rocmPackages.clr

    # Terminal
    zsh
    foot
    starship
    zoxide
    nvimpager

    # Applications
    zen-browser
    obsidian
    unstable.telegram-desktop
    qbittorrent

    # Multimedia
    ffmpeg
    qimgv
    mpv
    unstable.yt-dlp
    kdePackages.kdenlive
    unstable.spotify
    unstable.tauon

    # Gaming
    (unstable.bottles.override {removeWarningPopup = true;})
    freesm-launcher

    # Development
    graphviz
    delta # better git pager
    picotool
    zig
    unstable.python3
    unstable.go
    delve # go
    nodejs
    unstable.temurin-bin-26 # JDK
    rustc
    cargo
    gcc
    typst
    typstyle

    # Language servers and tooling
    zls
    llvmPackages_20.clang-tools
    tinymist
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
    gopls

    # Formatting
    stylua # lua
    sleek # sql
    sql-formatter
    rustfmt
    sqlfluff
    kdlfmt

    # LLM
    llmPkgs.opencode
    llmPkgs.codex
  ];

  # Work tools
  environment.variables = {
    EDITOR = "nvim";
    PSQL_PAGER = "pspg -X -s 1";
  };

  programs.git = {
    enable = true;
    config = {
      core.pager = "delta";
      user = {
        name = "noi";
        email = "noidor2019@gmail.com";
      };
      init.defaultBranch = "master";
      pull.rebase = true;
      merge.conflictStyle = "zdiff3";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        dark = true;
      };
      alias.sdiff = "-c delta.features=side-by-side diff";
      url = {
        "git@gitlab.com:".insteadOf = ["https://gitlab.com/"];
        "git@github.com:".insteadOf = ["https://github.com/"];
      };
    };
  };

  programs.direnv.enable = true;

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  # Gaming and music
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [proton-ge-bin];
    protontricks.enable = true;
  };

  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    package = pkgs.unstable.gamescope;
  };

  programs.honkers-railway-launcher.enable = true;

  programs.spicetify = {
    enable = false;
    enabledExtensions = with pkgs.spicePkgs.extensions; [
      adblockify
      hidePodcasts
    ];
  };

  # Desktop
  programs.niri.enable = false;

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  fonts.packages = with pkgs; [
    maple-mono.NF-CN
    zpix-pixel-font
    (callPackage ../../pkgs/vcr-osd-cyr-font/vcr-osd-cyr-font.nix {})
  ];

  # Networking
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false; # Unstable connectivity without this
      logLevel = "DEBUG";
    };
    extraHosts = ''
    '';
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
    };
  };

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # Audio and peripherals
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  services.printing.enable = true;
  services.pcscd.enable = true;

  # Boot and memory
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.unstable.linuxPackages_latest;
    kernelModules = [
      "nct6775"
      "i2c-dev"
      "msr"
    ];

    kernelParams = [
      "amdgpu.gpu_recovery=1"
    ];

    kernel.sysctl = {
      "kernel.sysrq" = 1;
      "kernel.watchdog_thresh" = 30; # reboot on softlock

      # Swapping with zram is much much faster than paging so we prioritize it.
      "vm.swappiness" = 180;

      # Prevents uncompressing any more than you absolutely have to,
      # with a minimal reduction to sequential throughput
      "vm.page-cluster" = 0;

      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
    };

    extraModprobeConfig = ''
      options hid_apple fnmode=0
    '';
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 4;
    enableNotifications = true;
  };

  # Hardware
  hardware = {
    graphics = {
      enable = true;
      package = pkgs.unstable.mesa;
    };
    amdgpu = {
      overdrive.enable = true;
      opencl.enable = true;
    };
    bluetooth.enable = true;
  };

  services.lact.enable = true;
  programs.coolercontrol.enable = true;

  # Nix
  services.selector4nix = {
    enable = true;
    configureSubstituter = "overwrite";
    settings.substituters = [
      # {url = "https://hyprland.cachix.org/";}

      {url = "https://cache.nixos.org/";}
      {url = "https://mirror.yandex.ru/nixos/";}
      # {url = "https://cache.xd0.zip/";}
      # {url = "https://cache.nixos.kz/";}
      # {url = "https://nixos-cache-proxy.cofob.dev/";}
      # {url = "https://nixos-cache-proxy.sweetdogs.ru/";}
      # {url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store/";}

      # {url = "https://nix-community.cachix.org/";}
      # {url = "https://cache.garnix.io/";}
      {url = "https://kopuz.cachix.org/";}
      {url = "https://ezkea.cachix.org/";} # aagl pkgs
    ];
  };

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

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "kopuz.cachix.org-1:J2X3AnAYhKTJW5S3aCLoA1ckonQXVNZMQvhZA0YAufw="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      ];

      cores = 8;
      max-jobs = 4;
    };
    optimise = {
      automatic = true;
      persistent = true;
      dates = ["Fri 23:00"];
    };
  };

  # Basic settings
  networking.hostName = "pc";
  time.timeZone = "Europe/Moscow";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  users.users.noi = {
    isNormalUser = true;
    description = "noi";
    extraGroups = ["networkmanager" "wheel"];
  };

  # State version
  system.stateVersion = "26.05";
}
