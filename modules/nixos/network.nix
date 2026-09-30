{self, ...}: {
  flake.nixosModules.network = {
    pkgs,
    config,
    ...
  }: {
    # NetworkManager
    networking.networkmanager = {
      enable = true;
      plugins = [pkgs.networkmanager-openvpn];
    };

    # OpenSSH
    services.openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };

    # Tailscale
    services.tailscale.enable = true;

    # Persistence
    environment = self.lib.mkIfPersistence config {
      directories = [
        "/var/lib/tailscale"
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"
      ];
    };
  };
}
