{
  flake.nixosModules.network = {
    networking = {
      networkmanager = {
        enable = true;
        dns = "none";
      };

      nameservers = [
        "9.9.9.9"
        "149.112.112.112"
      ];
    };

    persist.root.directories = [
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
