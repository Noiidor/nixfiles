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
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser2 = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager-unstable";
      };
    };

    kirsch-font = {
      url = "https://flakehub.com/f/molarmanful/kirsch/0.6.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.darwin.follows = "";
    };

    priv-env = {
      url = "git+ssh://git@gitlab.ozon.ru/rrodnyuk/nixenv.git";
      flake = false;
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
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

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        })
      ];
    };

    pkgsDarwin = import nixpkgs {
      system = system-darwin;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          unstable = import nixpkgs-unstable {
            system = system-darwin;
            config.allowUnfree = true;
          };
        })
      ];
    };

    # Meh
    vars = {
      fontName = "Maple Mono NF CN";
      release = "25.11";
    };
  in {
    #===
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit vars;
          inherit inputs;
        };
      };
    };

    homeConfigurations.noi = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
      ];
      extraSpecialArgs = {
        inherit vars;
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
