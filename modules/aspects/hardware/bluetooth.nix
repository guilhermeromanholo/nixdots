{self, ...}: {
  flake.modules.nixos.bluetooth = {config, ...}: {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    environment = self.lib.mkIfPersistence config {
      directories = ["/var/lib/bluetooth"];
    };
  };
}
