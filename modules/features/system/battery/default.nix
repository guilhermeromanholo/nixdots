{
  flake.nixosModules.battery = {
    services.tlp.enable = true;
    services.upower.enable = true;
  };
}
