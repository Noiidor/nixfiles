{pkgs, ...}: {
  config = (pkgs.formats.iniWithGlobalSection {}).generate "ghostty-config" {
    globalSection = {
      macos-option-as-alt = "left";
      keybind = "alt+left=unbind";
    };
  };
}
