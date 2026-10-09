{ inputs, ... }:
{
  flake.aspects.wsl.nixos = {
    imports = [
      inputs.nixos-wsl.nixosModules.default
    ];

    wsl.enable = true;
    wsl.usbip.enable = true;
  };
}
