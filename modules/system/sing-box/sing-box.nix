{pkgs, ...}: {
  services.sing-box = {
    enable = false;
    package = pkgs.unstable.sing-box;
    settings = {
    };
  };

  users.groups.sing-box = {};
  users.users.sing-box = {
    isSystemUser = true;
    group = "sing-box";
    extraGroups = ["acme"];
  };
}
