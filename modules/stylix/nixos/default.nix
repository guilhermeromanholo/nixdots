{
  inputs,
  lib,
  config,
  options,
  pkgs,
  ...
}: let
  cfg = config.modules.stylix;
  theme = import ../themes/${cfg.theme};
in {
  imports = [
    inputs.stylix.nixosModules.stylix
    ../shared/options.nix
  ];

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (import ../shared/core.nix {inherit theme pkgs;})

      (lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [(import ../shared/home.nix {inherit theme pkgs;})];
      })
    ]
  );
}
