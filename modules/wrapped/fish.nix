{ inputs, moduleWithSystem, ... }:
{
  flake.aspects.fish.nixos = moduleWithSystem (
    { self' }: {
      programs.fish = {
        enable = true;
        package = self'.packages.fish;
      };

      users.defaultUserShell = self'.packages.fish;
    }
  );

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
