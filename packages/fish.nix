{
  inputs,
  pkgs,
  lib,
  starship,
  ...
}:
inputs.wrappers.wrappers.fish.wrap {
  inherit pkgs;

  runtimePkgs = with pkgs; [
    eza
    zoxide
    ripgrep
    starship
  ];

  shellAliases = {
    cd = "z";
    ls = "eza --icons --group-directories-first";
    ll = "eza -l --icons --group-directories-first";
    la = "eza -la --icons --group-directories-first";
  };

  configFile.content = ''
    set -g fish_greeting ""
    zoxide init fish | source
    ${lib.getExe starship} init fish | source
  '';
}
