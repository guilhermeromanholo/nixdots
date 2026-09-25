{
  flake.nixosModules.firmware = {
    services.fwupd.enable = true;
    hardware.enableRedistributableFirmware = true;
  };
}
