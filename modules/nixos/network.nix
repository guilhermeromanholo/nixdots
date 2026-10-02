{self, ...}: {
  flake.modules.nixos.network = {pkgs, config, ...}: {
    networking.networkmanager = {
      enable = true;
      plugins = [pkgs.networkmanager-openvpn];
    };

    environment = self.lib.mkIfPersistence config {
      directories = [
        "/var/lib/bluetooth"
      ];
    };
  };
}
