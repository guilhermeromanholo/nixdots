{
  flake.nixosModules.network = { config, ... }: {
    services.tailscale = {
      enable = true;
      extraUpFlags = [ "--accept-routes" ];
    };

    users.users.${config.settings.user.name} = {
      extraGroups = [ "tailscale" ];
    };

    persist.root.directories = [ "/var/lib/tailscale" ];
  };
}
