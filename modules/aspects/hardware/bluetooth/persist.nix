{self, ...}: {
  flake.modules.nixos.bluetooth = {config, ...}: {
    environment = self.lib.mkIfPersistence config {
      directories = ["/var/lib/bluetooth"];
    };
  };
}
