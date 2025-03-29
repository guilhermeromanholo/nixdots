{
  inputs,
  lib,
  config,
  outputs,
  options,
  pkgs,
  ...
}: let
  cfg = config.modules.style;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.modules.style = {
    enable = lib.mkEnableOption "Style";

    theme = lib.mkOption {
      type = lib.types.attrs;
      default = outputs.themes.gruvbox;
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    # NixOS
    (import ./stylix {
      inherit pkgs;
      inherit (cfg) theme;
    })

    # Home-Manager
    (lib.optionalAttrs (options ? home-manager) {
      home-manager.sharedModules = [
        {
          modules.style = {
            enable = true;
            inherit (cfg) theme;
          };
        }
      ];
    })
  ]);
}
