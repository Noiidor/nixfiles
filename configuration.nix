{
  user,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration-laptop.nix
    ./modules/hyprland/hyprland.nix
    inputs.stylix.nixosModules.stylix
  ];

  # System config is a mess
  # I dont know what half of options does, but it works
  # TODO: Split into modules

  # List of stable packages
  environment.systemPackages = with pkgs; [
    # CLI utils
    dig
    usbutils
    inetutils

    # TUI
    mtr # ping + traceroute

    # Programming
    minikube
    k3d
    git

    # System
    home-manager
    wirelesstools
    wl-clipboard
    wireguard-tools

    # Disks
    gparted
    ntfs3g
    testdisk

    # Lib
    libadwaita
    libnotify

    # Other
  ];

  environment.variables = {
  };

  fonts.packages = with pkgs; [
    # nerdfonts
    liberation_ttf
    helvetica-neue-lt-std
    times-newer-roman
    arkpandora_ttf
    gelasio
  ];

  # BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];
  boot.kernel.sysctl."kernel.sysrq" = 502;
  boot.kernelParams = ["cgroup_enable=cpuset" "cgroup_enable=memory" "cgroup_memory=1" "preempt=full"];
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=0
  '';
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 100;
  };

  # NETWORKING
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = false; # Unstable connectivity without this
    };
    # Needed for Anime launchers
    extraHosts = ''
      0.0.0.0 log-upload-os.hoyoverse.com
      0.0.0.0 sg-public-data-api.hoyoverse.com
      0.0.0.0 hkrpg-log-upload-os.hoyoverse.com
      0.0.0.0 overseauspider.yuanshen.com
      0.0.0.0 apm-log-upload-os.hoyoverse.com
      0.0.0.0 zzz-log-upload-os.hoyoverse.com
    '';
    #networkmanager.dns = "none";
    # nameservers = ["8.8.8.8" "8.8.4.4" "1.1.1.1" "1.0.0.1"];

    firewall = {
      enable = true;
      allowedTCPPorts = [22];
      #allowedUDPPorts = [];
    };
  };

  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.mullvad-vpn.enable = true;

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

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

  services = {
    upower = {
      enable = true;
    };
    power-profiles-daemon.enable = true;
  };

  # Desktop Environment
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "hyprland;gtk";
  };

  services.xserver = {
    xkb = {
      layout = "us,ru";
      variant = "";
      options = "grp:alt_shift_toggle";
    };
    upscaleDefaultCursor = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware = {
    pulseaudio.enable = false;
    graphics.enable = true;
    bluetooth.enable = true;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  services.ratbagd.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    description = user;
    extraGroups = ["networkmanager" "wheel" "video" "docker" "wireshark"];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
    gamescope = {
      enable = true;
    };

    nh = {
      enable = true;
      flake = "/home/${user}/nixfiles";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 5d --keep 5";
      };
    };

    wireshark = {
      enable = true;
      # dumpcap.enable = true;
      # usbmon.enable = true;
    };
  };

  stylix = {
    enable = true;
    image = ./modules/stylix/wallpaper.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/hardcore.yaml";
  };

  services.flatpak.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  system.stateVersion = "24.11";
}
