{
  flake.nixosModules.bluetooth = {
    key = "nixdots:modules/hardware/bluetooth.nix:bluetooth";
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
    persist.root.directories = [ "/var/lib/bluetooth" ];
  };
}
