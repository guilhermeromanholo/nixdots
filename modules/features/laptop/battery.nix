{
  flake.modules.nixos.battery = {
    services.upower.enable = true;
    services.thermald.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
