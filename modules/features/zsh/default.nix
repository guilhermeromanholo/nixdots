{
  flake.nixosModules.zsh = { pkgs, ... }: {
    programs.zsh.enable = true;
    programs.zsh.package = pkgs.my.zsh;
  };
}
