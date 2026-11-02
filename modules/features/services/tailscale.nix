{ self, ... }:
{
  flake.modules.nixos.tailscale = { config, ... }: {
    # Enable tailscale and allow subnet
    # routes
    services.tailscale.enable = true;
    services.tailscale.extraUpFlags = [ "--accept-routes" ];

    # Persist tailscale configuration
    environment = self.lib.mkIfPersistence {
      inherit config;
      directories = [ "/var/lib/tailscale" ];
    };
  };
}
