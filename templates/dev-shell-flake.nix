{
  description = "Basic Dev shell";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        # Deps and libs
      ];

      shellHook = ''
        echo "Welcome to Shell!"
      '';

      env = {
      };
    };
  };
}
