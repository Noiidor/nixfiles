{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      copyToClipboard
      betterGenres
      autoSkip
      fullAppDisplay
      beautifulLyrics
      songStats
    ];
    enabledCustomApps = with spicePkgs.apps; [
      ncsVisualizer
    ];
    # theme = spicePkgs.themes.text;
    # colorScheme = "";
  };
}
