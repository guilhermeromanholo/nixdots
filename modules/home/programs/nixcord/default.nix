{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.nixcord;
in {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  options.modules.programs.nixcord = {
    enable = lib.mkEnableOption "Nixcord";
  };

  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;

      discord = {
        enable = false;
        vencord.enable = true;
      };

      vesktop.enable = true;
    };
  };
}
