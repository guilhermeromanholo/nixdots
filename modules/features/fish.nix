{lib, ...}: {
  flake.wrappers.fish = {
    wlib,
    pkgs,
    ...
  }: {
    imports = [wlib.wrapperModules.fish];

    runtimePkgs = with pkgs; [
      eza
      zoxide
      ripgrep
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
      ${lib.getExe pkgs.starship} init fish | source
    '';
  };
}
