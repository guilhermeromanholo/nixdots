{self, ...}: {
  flake.modules.nixos.tailscale = {config, ...}: {
    nixos.services.tailscale.enable = true;

    environment = self.lib.mkIfPersistence config {
      directories = ["/var/lib/tailscale"];
    };
  };
}
