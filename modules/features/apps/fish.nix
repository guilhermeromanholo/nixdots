{
  inputs,
  lib,
  ...
}: {
  flake.nixosModules.fish = inputs.self.lib.mkModule (
    {self', ...}: {
      programs.fish.enable = true;
      programs.fish.package = self'.packages.fish;
    }
  );

  perSystem = {pkgs, ...}: {
    packages.fish = inputs.wrappers.wrappers.fish.wrap {
      inherit pkgs;

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
  };
}
