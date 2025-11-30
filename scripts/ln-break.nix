{pkgs, ...}:
pkgs.writeShellApplication {
  name = "ln-break";
  text = "sed -i '' \"$1\"";
}
