{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  home.packages = [
    inputs.ghostty.packages.${pkgs.system}.default
  ];

  xdg.configFile.ghostty = {
    recursive = true;
    source = ./.;
  };
}
