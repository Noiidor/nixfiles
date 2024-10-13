{
  config,
  pkgs,
  pkgs-unstable,
  ...
} @ inputs: {
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
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
