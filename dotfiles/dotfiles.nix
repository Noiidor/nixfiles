{
  config,
  lib,
  pkgs,
  ...
} @ args:
builtins.readDir ./.
|> lib.filterAttrs (n: v: v == "directory")
|> builtins.attrNames
|> map (dir: {
  ${dir} = import ./${dir} args;
})
|> lib.mergeAttrsList
