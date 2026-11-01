{
  den.aspects.network = {
    nixos.networking.networkmanager.enable = true;

    persist.root.directories = [
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
