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
    (import ./core.nix {
      inherit (cfg) theme;
      inherit pkgs;
    })

    (lib.optionalAttrs (options ? home-manager) {
      home-manager.sharedModules = [
        (import ./icons.nix {
          inherit (cfg) theme;
          inherit pkgs;
        })

        (
          lib.mkIf config.services.xserver.desktopManager.gnome.enable
          (import ./gnome.nix {
            inherit (cfg) theme;
            inherit lib pkgs;
          })
        )
      ];
    })
  ]);
}
