{pkgs, ...}: {
  config =
    (pkgs.formats.json {}).generate "config.json" {
    };
}
