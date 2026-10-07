{
  flake.aspects.firmware.nixos = {
    services.fwupd.enable = true;
    hardware.enableRedistributableFirmware = true;
  };
}
