let
  keys = import ../keys.nix;
  allHosts = [keys.hosts.nixos];
in {
  "noi-hashed-password.age".publicKeys = allHosts;
  "mac-username.age".publicKeys = allHosts;
}
