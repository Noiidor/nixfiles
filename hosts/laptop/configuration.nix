{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./tmpfiles.nix
    ../../modules/niri/niri.nix
    ../../scripts/scripts.nix
    ../../modules/desktop.nix
    ../../agenix.nix
    ../../modules/vm/virt-manager.nix
    ../../modules/stylix/stylix.nix

    "${inputs.nixpkgs-unstable}/nixos/modules/services/hardware/tlp.nix"
    # "${inputs.nixpkgs-unstable}/nixos/modules/programs/throne.nix"
  ];

  disabledModules = [
    "services/hardware/tlp.nix"
  ];

  # TODO: Split into modules

  #=== Packages
  environment.systemPackages = with pkgs; [
    # CLI utils
    usbutils
    inetutils
    pciutils
    ddcutil
    fd
    ripgrep
    jq
    yq

    # System
    home-manager
    wirelesstools
    wl-clipboard
    wireguard-tools

    # Disks and FS
    gparted
    ntfs3g
    testdisk
    adbfs-rootless
    android-tools
    simple-mtpfs
    qdiskinfo # Disk health GUI

    # Network
    wireshark
    v2rayn

    # Lib
    libadwaita
    libnotify

    # Media
    unstable.yazi
    dragon-drop # Drag-n-drop utility
    hexyl # Hex binary viewer
    qimgv

    # Terminal
    zsh
    foot
    tmux
    starship
    zoxide
    neovim-nightly
    nvimpager

    # Desktop
    waybar
    unstable.telegram-desktop

    # Programming
    git
    delta # better git pager
    zls
    zig
    delve # go

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
    biome # json, js
    sleek # sql
    sql-formatter
    yamlfmt
    rustfmt
    sqlfluff
    kdlfmt
    alejandra

    # Other
    taskwarrior3
    kicad-small
    localsend
    deskflow
    agenix

    # Media
    zen-browser

    # LLM
    llmPkgs.claude-code
    llmPkgs.claude-code-router
    llmPkgs.opencode
  ];

  environment.variables = {
    EDITOR = "nvim";
    PSQL_PAGER = "pspg -X -s 1";

    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3"; # Fixes Telegram file picker
  };

  #=== Boot and kernel
  boot = {
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    supportedFilesystems = ["ntfs"];
    kernel.sysctl = {
      "kernel.sysrq" = 1;

      # Swapping with zram is much much faster than paging so we prioritize it.
      "vm.swappiness" = 180;

      # Prevents uncompressing any more than you absolutely have to,
      # with a minimal reduction to sequential throughput
      "vm.page-cluster" = 0;

      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
    };
    kernelParams = [
      "cgroup_enable=cpuset"
      "cgroup_enable=memory"
      "cgroup_memory=1"
      "preempt=full"
      "init_on_alloc=0"
      "init_on_free=0"
    ];
    kernelModules = [
      "i2c-dev"
    ];
    extraModprobeConfig = ''
      options hid_apple fnmode=0
    '';
    kernelPatches = [
    ];
  };

  #=== Disks and memory
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 200;
  };

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 6;
    enableNotifications = true;
  };

  services.fwupd.enable = true;

  services.udisks2.enable = true;

  systemd.services.adbd = {
    enable = true;
    path = [pkgs.android-tools];
    serviceConfig = {
      User = "root";
      Group = "root";
      ExecStart = "adb start-server";
    };
  };

  services.udev.extraRules = ''
    # set nvme scheduler
    ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="adios"
  '';

  systemd.tmpfiles.rules = [
    "d /run/media/noi/android 0755 noi users - -"
    "d /run/media/noi/drive 0755 noi users - -"
  ];

  #=== Networking
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = false; # Unstable connectivity without this
      logLevel = "DEBUG";
    };
    # Needed for Anime launchers
    extraHosts = ''
      0.0.0.0 log-upload-os.hoyoverse.com
      0.0.0.0 sg-public-data-api.hoyoverse.com
      0.0.0.0 hkrpg-log-upload-os.hoyoverse.com
      0.0.0.0 overseauspider.yuanshen.com
      0.0.0.0 apm-log-upload-os.hoyoverse.com
      0.0.0.0 zzz-log-upload-os.hoyoverse.com
      130.255.77.28 ntc.party
    '';
    #networkmanager.dns = "none";
    # nameservers = ["9.9.9.9" "8.8.8.8" "8.8.4.4" "1.1.1.1" "1.0.0.1"];
    # interfaces = {
    #   xray-tun = {
    #     virtual = true;
    #     virtualType = "tun";
    #     mtu = 1500;
    #     ipAddress = "172.19.0.1/30";
    #   };
    # };
    #
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
      #allowedUDPPorts = [];
    };
  };

  services = {
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    mullvad-vpn.enable = true;
  };

  programs = {
    wireshark = {
      enable = true;
      dumpcap.enable = true;
      usbmon.enable = true;
    };
  };

  #=== Virtualization and containerization
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  #=== i18n
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  #=== Desktop Environment
  services.displayManager = {
    sddm = {
      enable = false;
      wayland.enable = true;
    };
    ly = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = ["gtk"];
      };
    };
  };

  fonts.packages = with pkgs; [
    # nerdfonts
    # liberation_ttf
    # helvetica-neue-lt-std
    # times-newer-roman
    # arkpandora_ttf
    # gelasio
    # nerd-fonts.terminess-ttf
    # terminus_font
    maple-mono.NF-CN
    zpix-pixel-font
    # (callPackage ./pkgs/vcr-osd-font.nix {})
    (callPackage ../../pkgs/vcr-osd-cyr-font/vcr-osd-cyr-font.nix {})
    # nerd-fonts.iosevka
    # inputs.kirsch-font.packages.${pkgs.system}.kirsch-nerd
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # This fixes DaVinci Resolve "Unsupported GPU processing mode" error
        rocmPackages.clr.icd
      ];
    };
    bluetooth.enable = true;
  };

  #=== Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  #=== Inputs
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        # NOTE: Use wev to find key names.
        main = {
          # backspace = "delete"; # Delete key on backspace.
          # Long hold shift + caps = caps. Caps = keyboard layout
          capslock = "overload(shift, capslock)";
        };
      };
    };
  };

  # services.ratbagd.enable = false; # Mouse configuration

  #=== Users and apps
  users.mutableUsers = false;
  users.users.noi = {
    isNormalUser = true;
    description = "based";
    extraGroups = ["networkmanager" "wheel" "video" "dialout"];
    initialHashedPassword = "$y$j9T$NFyRSgzNAAxZVnqnS61MB.$JX.8U3roQwiI7E/3NUIKWeSuEPlCpwJRl5FzIaF9nW0";
    hashedPasswordFile = config.age.secrets.noi-hashed-password.path;
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    zoxide.enable = true;

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
        };
      };
    };

    throne = {
      enable = true;
      tunMode.enable = true;
    };
  };

  #=== Other
  services = {
    upower = {
      enable = true;
    };
    power-profiles-daemon.enable = false;
    tlp = {
      pd = {
        enable = true;
        package = pkgs.unstable.tlp-pd;
      };
      enable = true;
    };
    envfs.enable = true;
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
    channel.enable = false;
    registry = {
      unstable = {
        from = {
          id = "unstable";
          type = "indirect";
        };
        to = {
          type = "github";
          owner = "NixOS";
          repo = "nixpkgs";
          ref = "nixos-unstable";
        };
      };
    };

    settings = {
      trusted-users = ["noi"];
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

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
        "https://attic.xuyh0120.win/lantian?priority=10"
        "https://cache.garnix.io?priority=11"
      ];
      trusted-public-keys = [
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];

      cores = 4;
      max-jobs = 3;
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

  system.stateVersion = "25.11";
}
