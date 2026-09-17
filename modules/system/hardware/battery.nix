{
  flake.modules.nixos.battery = {
    powerManagement.enable = true;

    services.tlp.enable = true;
    services.thermald.enable = true;
  };
}
