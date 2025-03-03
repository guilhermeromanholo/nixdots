{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.services.docker;
in {
  options.modules.services.docker = {
    enable = lib.mkEnableOption "Docker";
  };

  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true;
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];
  };
}
