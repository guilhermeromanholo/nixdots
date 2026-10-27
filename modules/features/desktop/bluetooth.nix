{
  flake.modules.nixos.bluetooth = {
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;

    persist.root.dirs = [
      "/var/lib/bluetooth"
    ];
  };
}
