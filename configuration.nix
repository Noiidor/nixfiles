{
  user,
  pkgs,
  pkgs-unstable,
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

  nixpkgs.config.allowUnfree = true;
  # List of stable packages
  environment.systemPackages =
    (with pkgs; [
      # CLI utils
      gnumake
      dig
      unzip
      usbutils

      # TUI
      mtr

      # Programming
      postgresql_16
      minikube
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
      ffmpeg

      # Other
    ])
    ++
    # List of unstable(rolling-release) packages
    (with pkgs-unstable; [
      # Programming
    ]);

  environment.variables = {
  };

  fonts.packages = with pkgs; [
    nerdfonts
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
  boot.kernelParams = ["cgroup_enable=cpuset" "cgroup_enable=memory" "cgroup_memory=1"];
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
    # Needed for Honkers Railway launcher
    extraHosts = ''
      0.0.0.0 log-upload-os.hoyoverse.com
      0.0.0.0 sg-public-data-api.hoyoverse.com
      0.0.0.0 hkrpg-log-upload-os.hoyoverse.com
    '';
    #networkmanager.dns = "none";
    nameservers = ["8.8.8.8" "8.8.4.4" "1.1.1.1" "1.0.0.1"];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
  services.mullvad-vpn.enable = true;

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  time.timeZone = "Asia/Ho_Chi_Minh";

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

  # Desktop Environment
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
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
    extraGroups = ["networkmanager" "wheel" "video" "docker"];
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

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "24.11";
}
