{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.themes;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
    ./gruvbox
  ];

  options.modules.themes = {
    enable = lib.mkEnableOption "Themes";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;

      fonts = {
        monospace = {
          name = "FiraCode Nerd Font Mono";
          package = pkgs.nerd-fonts.fira-code;
        };

        sansSerif = {
          name = "Open Sans";
          package = pkgs.open-sans;
        };

        serif = {
          name = "Roboto Serif";
          package = pkgs.roboto-serif;
        };
      };
    };
  };
}
