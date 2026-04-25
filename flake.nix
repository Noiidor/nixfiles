{
  description = "System flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
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

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    llm-agents.url = "github:numtide/llm-agents.nix";

    freesm-launcher = {
      url = "github:freesmteam/freesmlauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-darwin,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    system-darwin = "aarch64-darwin";

    overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned

      (final: prev: {
        unstable = import nixpkgs-unstable {
          system = prev.system;
          config.allowUnfree = true;
        };

        neovim-nightly = inputs.neovim-nightly-overlay.packages.${prev.stdenv.hostPlatform.system}.default;
        agenix = inputs.agenix.packages.${prev.stdenv.hostPlatform.system}.default;
        zen-browser = inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
        llmPkgs = inputs.llm-agents.packages.${prev.stdenv.hostPlatform.system};
        freesm-launcher = inputs.freesm-launcher.packages.${prev.stdenv.hostPlatform.system}.default;
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
    # Meh
  in {
    #===
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/laptop/configuration.nix
          ./hosts/laptop/hardware-configuration-laptop.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      test_vm = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/laptop/configuration.nix
          ({modulesPath, ...}: {
            imports = [(modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")];
          })
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      pc = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./hosts/pc/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
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
