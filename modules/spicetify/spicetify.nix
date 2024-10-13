{
  config,
  lib,
  specialArgs,
  pkgs,
  pkgs-unstable,
  inputs,
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
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
      keyboardShortcut
      songStats
    ];
    enabledCustomApps = with spicePkgs.apps; [
      ncsVisualizer
    ];
    theme = spicePkgs.themes.lucid;
    colorScheme = "";
  };
}
