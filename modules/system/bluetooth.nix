{
  flake.aspects.bluetooth = {
    nixos = {
      services.blueman.enable = true;
      hardware.bluetooth.enable = true;
    };

    persist.root.directories = [
      "/var/lib/bluetooth"
    ];
  };
}
