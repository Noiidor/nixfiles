{
  pkgs,
  inputs,
  lib,
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
    # Remover mkForce to use Stylix theme
    theme = lib.mkForce spicePkgs.themes.hazy;
    colorScheme = lib.mkForce "";
  };
}
