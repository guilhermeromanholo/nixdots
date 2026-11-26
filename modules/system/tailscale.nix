{
  flake.nixosModules.tailscale = { config, ... }: {
    key = "nixdots:modules/system/tailscale.nix:tailscale";
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
