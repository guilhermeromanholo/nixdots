{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.shell.zsh;
in {
  options.modules.shell.zsh = {
    enable = lib.mkEnableOption "Zsh";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      devenv
      ripgrep
    ];

    programs.bat = {
      enable = true;
    };

    programs.eza = {
      enable = true;
      icons = "auto";
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.direnv = {
      enable = true;
      silent = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    home.sessionVariables.DIRENV_LOG_FORMAT = "";

    programs.zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./.;
          file = "p10k.zsh";
        }
      ];

      shellAliases = {
        dots = "z ~/.nixdots";
        cat = "bat";
        vim = "nvim";
        gs = "git status";
      };
    };
  };
}
