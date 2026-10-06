{
  den.aspects.battery.nixos = {
    powerManagement.enable = true;

    services.tlp.enable = true;
    services.thermald.enable = true;
  };
}
