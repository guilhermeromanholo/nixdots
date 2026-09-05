{self, ...}: {
  flake.modules.nixos.tailscale = {config, ...}: {
    environment = self.lib.mkIfPersistence config {
      directories = ["/var/lib/tailscale"];
    };
  };
}
