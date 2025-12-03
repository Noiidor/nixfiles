{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (config.networking) hostName;
  key = (import ./secrets/keys.nix).hosts.${hostName} or ""; # Current host pubkey
  secrets = import ./secrets/age/secrets.nix;
in {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age = {
    secrets =
      secrets
      |> lib.filterAttrs (n: v: builtins.elem key v.publicKeys)
      |> lib.concatMapAttrs (n: v: {
        ${n |> lib.removeSuffix ".age"}.file = ./secrets/age/${n};
      });
  };
}
