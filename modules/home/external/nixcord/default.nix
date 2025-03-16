{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.external.nixcord;
in {
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  options.modules.external.nixcord = {
    enable = lib.mkEnableOption "Nixcord";
  };

  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
    };
  };
}
