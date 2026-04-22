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
      # copyToClipboard # Bugged
      betterGenres
      fullAppDisplay
      beautifulLyrics
      songStats
    ];
    enabledCustomApps = with spicePkgs.apps; [
    ];
    # Remove mkForce to use Stylix theme
    theme = lib.mkForce spicePkgs.themes.text;
    colorScheme = lib.mkForce "";
  };
}
