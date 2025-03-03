{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.hardware.audio;
in {
  options.modules.hardware.audio = {
    enable = lib.mkEnableOption "Audio";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;

      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };
}
