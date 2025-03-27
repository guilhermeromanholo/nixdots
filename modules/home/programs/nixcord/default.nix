{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.nixcord;
in {
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  options.modules.programs.nixcord = {
    enable = lib.mkEnableOption "Nixcord";
  };

  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
    };
  };
}
