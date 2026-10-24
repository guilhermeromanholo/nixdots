{
  flake.modules.nixos.network = {
    host,
    pkgs,
    ...
  }: {
    networking.hostName = host.name;

    networking.networkmanager = {
      enable = true;
      plugins = [pkgs.networkmanager-openvpn];
    };

    services.tailscale = {
      enable = true;
      extraSetFlags = ["--accept-routes"];
    };

    persist.root.dirs = [
      "/var/lib/tailscale"
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
