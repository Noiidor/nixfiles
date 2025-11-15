{inputs, ...}: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    packages = [
      # Flatpak apps goes here
    ];
    update.onActivation = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
