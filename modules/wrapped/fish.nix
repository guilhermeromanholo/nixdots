{ inputs, ... }:
{
  perSystem = { pkgs, ... }: {
    packages.fish = inputs.wrappers.wrappers.fish.wrap {
      inherit pkgs;

      runtimePkgs = with pkgs; [
        eza
        zoxide
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
      '';
    };
  };
}
