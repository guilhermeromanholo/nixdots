{
  lib,
  config,
  ...
}: let
  cfg = config.modules.services.grafana;
in {
  options.modules.services.grafana = {
    enable = lib.mkEnableOption "Grafana";
  };

  config = lib.mkIf cfg.enable {
    services.grafana = {
      enable = true;
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 3000;
        };
      };
    };
  };
}
