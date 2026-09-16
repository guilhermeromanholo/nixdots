{
  den.aspects.network = {
    nixos = {pkgs, ...}: {
      networking.networkmanager = {
        enable = true;
        plugins = with pkgs; [networkmanager-openvpn];
      };
    };

    persist.directories = [
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
