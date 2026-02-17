{
  flake.modules.nixos.network = {config, ...}: let
    cfg = config.constants;
  in {
    networking.hostName = cfg.hostname;
    networking.networkmanager.enable = true;
  };
}
