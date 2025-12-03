{pkgs, ...}: {
  config = (pkgs.formats.iniWithGlobalSection {}).generate "mako-config" {
    globalSection = {
      anchor = "top-right";
      background-color = "#222222FD";
      border-color = "#6A6057FD";
      default-timeout = (sec: sec * 1000) 10;
      font = "VCR OSD Mono [RUS by Daymarius] 12";
      height = 120;
      margin = 24;
      padding = 10;
      max-visible = 3;
      text-color = "#F2AFFDFD";
      width = 400;
    };
  };
}
