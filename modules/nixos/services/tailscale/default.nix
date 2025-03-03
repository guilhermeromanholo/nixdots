{
  lib,
  config,
  ...
}: let
  cfg = config.modules.services.tailscale;
in {
  options.modules.services.tailscale = {
    enable = lib.mkEnableOption "Tailscale";
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
    };
  };
}
