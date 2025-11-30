{pkgs, ...}: {
  config = (pkgs.formats.toml {}).generate "yazi.toml" {
    mgr = {
      show_hidden = true;
      sort_by = "mtime";
      sort_reverse = true;
      ratio = [1 3 4];
      linemode = "size";
    };
    preview = {
      max_width = 800;
    };
    plugin = {
      prepend_previewers = [
        {
          name = "*.md";
          run = "glow";
        }
      ];
    };
  };
  keymap = (pkgs.formats.toml {}).generate "keymap.toml" {
    mgr = {
      prepend_keymap = [
        {
          on = "<C-n>";
          run = "shell -- dragon-drop -x -i -a -T \"$@\"";
        }
      ];
    };
  };

  theme =
    (pkgs.formats.toml {}).generate "theme.toml" {
    };
}
