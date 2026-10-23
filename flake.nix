{
  description = "System flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xwayland-sattelite.url = "github:Supreeeme/xwayland-satellite";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager-unstable";
      };
    };

    # kirsch-font = {
    #   url = "https://flakehub.com/f/molarmanful/kirsch/0.6.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.darwin.follows = "";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    selector4nix.url = "github:StarryReverie/selector4nix";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    niko-kernel = {
      url = "github:NikoMalik/nix-niko-kernel";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    llm-agents.url = "github:numtide/llm-agents.nix";

    freesm-launcher = {
      url = "github:freesmteam/freesmlauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eden-emulator = {
      url = "github:Daaboulex/eden-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kopuz.url = "github:temidaradev/kopuz";

    hermes.url = "github:nousresearch/hermes-agent";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-darwin,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    system-darwin = "aarch64-darwin";

    overlays = [
      inputs.nix-cachyos-kernel.overlays.default
      inputs.eden-emulator.overlays.default

      (_: prev: let
        system = prev.stdenv.hostPlatform.system;
      in {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };

        neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.default;
        agenix = inputs.agenix.packages.${system}.default;
        zen-browser = inputs.zen-browser.packages.${system}.default;
        llmPkgs = inputs.llm-agents.packages.${system};
        freesm-launcher = inputs.freesm-launcher.packages.${system}.default;
        kopuz = inputs.kopuz.packages.${system}.default;
        aaglPkgs = inputs.aagl.packages.${system};
        hermes-agent = inputs.hermes.packages.${system}.default;
        spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
      })
    ];

    pkgs = import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };

    pkgsDarwin = import nixpkgs {
      system = system-darwin;
      config.allowUnfree = true;
      inherit overlays;
    };

    mkNixos = modules:
      nixpkgs.lib.nixosSystem {
        inherit pkgs modules;
        specialArgs = {inherit inputs;};
      };
  in {
    #===
    nixosConfigurations = {
      nixos = mkNixos [
        ./hosts/laptop/configuration.nix
        ./hosts/laptop/hardware-configuration-laptop.nix
      ];

      test_vm = mkNixos [
        ./hosts/laptop/configuration.nix
        ({modulesPath, ...}: {
          imports = [(modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")];
        })
      ];

      pc = mkNixos [./hosts/pc/configuration.nix];

      main = mkNixos [./hosts/main/configuration.nix];
    };

    homeConfigurations.noi = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./users/noi.nix
      ];
      extraSpecialArgs = {
        inherit inputs;
      };
    };

    #===
    darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
      system = system-darwin;
      modules = [./hosts/macbook/default.nix];
      specialArgs = {
        inherit inputs;
      };
    };

    homeConfigurations.rrodnyuk = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsDarwin;
      modules = [./users/rrodnyuk.nix];
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}
