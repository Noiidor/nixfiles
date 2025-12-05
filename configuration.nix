{
  user,
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration-laptop.nix
    inputs.stylix.nixosModules.stylix
    # ./modules/hyprland/hyprland.nix
    ./modules/niri/niri.nix
    ./scripts/scripts.nix
    ./modules/desktop.nix
    ./tmpfiles.nix
    # ./modules/clamav.nix
    ./agenix.nix
    ./modules/vm/virt-manager.nix
  ];

  # TODO: Split into modules

  #=== Packages
  environment.systemPackages = with pkgs; [
    # CLI utils
    usbutils
    inetutils
    pciutils

    # Programming
    git

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

    # Network
    wireshark

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

    # Desktop
    waybar

    # Other
  ];

  environment.variables = {
    EDITOR = "nvim";
    PSQL_PAGER = "pspg -X -s 1";

    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = lib.mkForce "gtk3"; # Fixes Telegram file picker
  };

  #=== Boot and kernel
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
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
    ];
    extraModprobeConfig = ''
      options hid_apple fnmode=0
    '';
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
    # set bfq scheduler for non-rotating disks
    ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"
  '';

  systemd.tmpfiles.rules = ["d /run/media/noi/android 0755 noi users - -"];

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
    (callPackage ./pkgs/vcr-osd-cyr-font/vcr-osd-cyr-font.nix {})
    # nerd-fonts.iosevka
    # inputs.kirsch-font.packages.${pkgs.system}.kirsch-nerd
  ];

  stylix = {
    enable = true;
    image = ./modules/stylix/wallpaper.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/hardcore.yaml";
  };

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
  users.users.${user} = {
    isNormalUser = true;
    description = user;
    extraGroups = ["networkmanager" "wheel" "video" "dialout"];
    hashedPasswordFile = config.age.secrets.noi-hashed-password.path;
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;

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
        user = {
          name = "noi";
          email = "noidor2019@gmail.com";
        };
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
  };

  #=== Other
  services = {
    upower = {
      enable = true;
    };
    power-profiles-daemon.enable = true;
  };

  #=== Nix
  programs.nh = {
    enable = true;
    flake = "/home/${user}/nixfiles";
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

    settings =
      {
        trusted-users = ["noi"];
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        substituters = [
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        cores = 4;
        max-jobs = 3;
      }
      // inputs.aagl.nixConfig;

    optimise = {
      automatic = true;
      persistent = true;
      dates = ["Fri 23:00"];
    };
  };

  system.stateVersion = "25.11";
}
