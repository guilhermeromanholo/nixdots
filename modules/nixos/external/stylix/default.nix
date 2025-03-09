{
  inputs,
  outputs,
  lib,
  config,
  options,
  pkgs,
  ...
}: let
  cfg = config.modules.external.stylix;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.modules.external.stylix = {
    enable = lib.mkEnableOption "Stylix";

    theme = lib.mkOption {
      type = lib.types.attrs;
      default = outputs.themes.gruvbox;
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      stylix = {
        enable = true;

        image = cfg.theme.image;
        polarity = cfg.theme.polarity;
        base16Scheme = cfg.theme.colorscheme;

        cursor = {
          name = cfg.theme.cursor.name;
          package = pkgs.${cfg.theme.cursor.package};
          size = 15;
        };

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
    }
    (lib.optionalAttrs (options ? home-manager) {
      home-manager.sharedModules = [
        {
          gtk.iconTheme = {
            name = cfg.theme.icon.name;
            package = pkgs.${cfg.theme.icon.package};
          };
        }
      ];
    })
  ]);
}
