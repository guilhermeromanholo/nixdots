{ lib, ... }:
{
  flake.nixosModules.zsh = { pkgs, ... }: {
    key = "nixdots:modules/programs/zsh/default.nix:zsh";
    settings.user.shell = lib.mkDefault pkgs.my.zsh;
    programs.zsh.enable = true;
    programs.zsh.package = pkgs.my.zsh;
  };
}
