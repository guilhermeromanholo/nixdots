{ self, ... }:
{
  flake.modules.nixos.bluetooth = { config, ... }: {
    # Enable bluetooth and blueman
    # to manage devices
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;

    # Directory with paired devices
    # configurations
    environment = self.lib.mkIfPersistence {
      inherit config;
      directories = [ "/var/lib/bluetooth" ];
    };
  };
}
