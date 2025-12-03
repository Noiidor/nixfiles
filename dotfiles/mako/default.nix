{pkgs, ...}: {
  config = (pkgs.formats.iniWithGlobalSection {}).generate "mako-config" {
    globalSection = {
      anchor = "top-right";
      background-color = "#222222FD";
      border-color = "1C1C1CFD";
      default-timeout = 10;
      font = "VCR OSD Mono 10";
      height = 120;
      margin = 32;
      max-visible = 3;
      text-color = "F2AFFDFD";
      width = 400;
    };
  };
}
