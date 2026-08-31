{self, ...}: {
  flake.modules.nixos.bluetooth = {config, ...}: {
    hardware.bluetooth.enable = true;

    environment = self.lib.mkIfPersistence config {
      persistence."/persist".directories = [
        "/var/lib/bluetooth"
      ];
    };
  };
}
