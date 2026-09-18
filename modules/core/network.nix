{self, ...}: {
  flake.modules.nixos.network = {
    pkgs,
    config,
    ...
  }: {
    networking.networkmanager = {
      enable = true;
      plugins = with pkgs; [networkmanager-openvpn];
    };

    environment = self.lib.mkIfPersistence config {
      directories = [
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"
      ];
    };
  };
}
