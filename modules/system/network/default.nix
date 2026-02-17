{
  flake.modules.nixos.network = {config, ...}: let
    cfg = config.settings;
  in {
    networking.hostName = cfg.hostname;
    networking.networkmanager.enable = true;
  };
}
