{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages =
    lib.filesystem.listFilesRecursive ./.
    |> builtins.filter (file: lib.hasSuffix ".nix" file)
    |> builtins.filter (file: builtins.baseNameOf file != "scripts.nix")
    |> map (n: pkgs.callPackage n {});
}
