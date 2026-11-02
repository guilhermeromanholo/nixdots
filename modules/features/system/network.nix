{ self, ... }:
{
  flake.modules.nixos.network = { config, ... }: {
    networking = {
      # Enable NetworkManager
      networkmanager = {
        enable = true;
        # Disable router DNS
        dns = "none";
      };

      # Quad9 nameservers
      nameservers = [
        "9.9.9.9"
        "149.112.112.112"
      ];
    };

    # Directories to persist
    environment = self.lib.mkIfPersistence {
      inherit config;
      directories = [
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"
      ];
    };
  };
}
