{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.tmux = {
    enable = true;
    shell = "$SHELL";
    clock24 = true;
    keyMode = "vi";
    prefix = "C-Space";
    baseIndex = 1;
  };
}
