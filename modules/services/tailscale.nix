{self, ...}: {
  flake.modules.nixos.tailscale = {config, ...}: {
    services.tailscale.enable = true;

    environment = self.lib.mkIfPersistence config {
      directories = ["/var/lib/tailscale"];
    };
  };
}
