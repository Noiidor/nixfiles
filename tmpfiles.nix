{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  dotfiles = import ./dotfiles/dotfiles.nix args;
  mkHome = user: files: {
    ${user}.rules =
      files
      |> map (
        func: func user
      );
  };
  mkDir = path: user: "d %h/${path} 0755 ${user} users - -";
  mkLink = path: target: user: "L+ %h/${path} 0755 ${user} users - ${target}";
  rm = path: user: "R %h/${path} - - - - -";
in {
  systemd.user.tmpfiles.users =
    [
      (mkHome "noi"
        [
          (mkDir ".test")
          (rm "fio")
          (mkLink ".config/test" "/home/noi/random.file")
          (mkLink ".config/foot/foot.ini" dotfiles.foot.config)

          (mkLink ".config/qimgv/qimgv.conf" dotfiles.qimgv.config)
          (mkLink ".config/qimgv/theme.conf" dotfiles.qimgv.theme)

          (mkLink ".config/yazi/yazi.toml" dotfiles.yazi.config)
          (mkLink ".config/yazi/keymap.toml" dotfiles.yazi.keymap)
          (mkLink ".config/yazi/theme.toml" dotfiles.yazi.theme)

          (mkLink ".config/tmux/tmux.conf" dotfiles.tmux.config)

          (mkLink ".zshrc" dotfiles.zsh.config)

          (mkLink ".config/starship.toml" dotfiles.starship.config)

          (mkLink ".config/mako/config" dotfiles.mako.config)
        ])
    ]
    |> lib.mergeAttrsList;
}
