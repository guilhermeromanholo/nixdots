{self, ...}: {
  flake.modules.nixos.bluetooth = {config, ...}: {
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;

    environment = self.lib.mkIfPersistence config {
      directories = [
        "/var/lib/bluetooth"
      ];
    };
  };
}
