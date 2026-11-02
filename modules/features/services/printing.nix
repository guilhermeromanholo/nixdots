{ self, ... }:
{
  flake.modules.nixos.printing = { config, pkgs, ... }: {
    # Enable CUPS service
    services.printing = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
    };

    # Enable sane for scanners
    hardware.sane.enable = true;

    # Persist printers and CUPS configurations
    environment = self.lib.mkIfPersistence {
      inherit config;
      directories = [ "/etc/cups" ];
    };
  };
}
