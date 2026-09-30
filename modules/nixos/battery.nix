{
  flake.nixosModules.battery = {
    powerManagement.enable = true;

    services.tlp.enable = true;
    services.thermald.enable = true;
  };
}
