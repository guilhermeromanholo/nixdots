{ lib, ... }:
{
  flake.wrappers.zsh = { wlib, pkgs, ... }: {
    imports = [ wlib.wrapperModules.zsh ];

    zshAliases = {
      cat = lib.getExe pkgs.bat;
      ls = "${lib.getExe pkgs.eza} --icons --group-directories-first";
      ll = "${lib.getExe pkgs.eza} -l --icons --group-directories-first";
      la = "${lib.getExe pkgs.eza} -la --icons --group-directories-first";
    };
  };
}
