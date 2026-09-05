{self, ...}: {
  flake.modules.nixos.network = {config, ...}: {
    environment = self.lib.mkIfPersistence config {
      directories = [
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"
      ];
    };
  };
}
