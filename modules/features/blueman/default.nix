{
  flake.nixosModules.blueman = {
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
  };
}
