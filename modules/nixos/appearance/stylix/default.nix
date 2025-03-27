{
  inputs,
  outputs,
  lib,
  config,
  options,
  pkgs,
  ...
}: let
  cfg = config.modules.appearance.stylix;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.modules.appearance.stylix = {
    enable = lib.mkEnableOption "Stylix";

    colorscheme = lib.mkOption {
      type = lib.types.str;
      default = "gruvbox";
    };
  };

  config = let
    theme = import ../themes/${cfg.colorscheme};
  in lib.mkIf cfg.enable (lib.mkMerge [
    (import ./core.nix {
      inherit theme;
      inherit pkgs;
    })

    (lib.optionalAttrs (options ? home-manager) {
      home-manager.sharedModules = [
        (import ./icons.nix {
          inherit theme;
          inherit pkgs;
        })

        (
          lib.mkIf config.services.xserver.desktopManager.gnome.enable
          (import ./gnome.nix {
            inherit theme;
            inherit lib pkgs;
          })
        )
      ];
    })
  ]);
}
