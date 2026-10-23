{
  flake.modules.nixos.network = {pkgs, ...}: {
    networking.networkmanager = {
      enable = true;
      plugins = [pkgs.networkmanager-openvpn];
    };

    services.tailscale = {
      enable = true;
      extraSetFlags = ["--accept-routes"];
    };

    persist.root.directories = [
      "/var/lib/tailscale"
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
