{pkgs, ...}: {
  config = pkgs.replaceVars ./.zshrc {
    zsh-autosuggestions-pkg = pkgs.zsh-autosuggestions;
    vte-pkg = pkgs.vte;
    zsh-fsh-pkg = pkgs.zsh-fast-syntax-highlighting;
  };
}
