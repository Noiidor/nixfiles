{
  description = "Basic FHS env";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default =
      (pkgs.buildFHSEnv
        {
          name = "fhs-env";
          targetPkgs = pkgs: (with pkgs; [
            # Libs
          ]);
          runScript = "$SHELL";
        })
      .env;
  };
}
