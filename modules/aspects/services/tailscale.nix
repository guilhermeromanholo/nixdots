{
  den.aspects.tailscale = {
    nixos = {
      services.tailscale.enable = true;
      services.tailscale.extraUpFlags = [ "--accept-routes" ];
    };

    persist.root.directories = [
      "/var/lib/tailscale"
    ];
  };
}
