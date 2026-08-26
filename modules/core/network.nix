{self, ...}: {
  flake.modules.nixos.network = {config, ...}: {
    networking.networkmanager.enable = true;

    environment = self.lib.mkIfPersistence config {
      persistence."/persist".directories = [
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"
      ];
    };
  };
}
