{
  description = "My default flake.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./configuration.nix];
        specialArgs = {
          inherit pkgs-unstable;
        };
      };
    };

    homeConfigurations.noi = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
        # {
        #   imports = [inputs.aagl.nixosModules.default];
        #   # nix.settings = inputs.aagl.nixConfig; # Set up Cachix
        #   # programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
        #   # programs.anime-games-launcher.enable = true;
        #   # programs.anime-borb-launcher.enable = true;
        #   programs.honkers-railway-launcher.enable = true;
        #   # programs.honkers-launcher.enable = true;
        #   # programs.wavey-launcher.enable = true;
        #   # programs.sleepy-launcher.enable = true;
        # }
      ];
      extraSpecialArgs = {
        inherit pkgs-unstable;
        inherit inputs;
      };
    };
  };
}
