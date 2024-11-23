{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    packages = [
      "io.github.zen_browser.zen"
    ];
    update.onActivation = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
