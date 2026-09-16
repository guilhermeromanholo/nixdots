{
  den.aspects.bluetooth = {
    nixos = {
      services.blueman.enable = true;
      hardware.bluetooth.enable = true;
    };

    persist.directories = [
      "/var/lib/bluetooth"
    ];
  };
}
