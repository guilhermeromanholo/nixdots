{
  flake.nixosModules.boot = {
    key = "nixdots:modules/system/boot.nix:boot";
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
