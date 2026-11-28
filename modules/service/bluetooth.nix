{
  flake.modules.nixos.bluetooth = {
    hardware.bluetooth.enable = true;
    persist.root.directories = [ "/var/lib/bluetooth" ];
  };
}
