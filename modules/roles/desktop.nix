{self, ...}: {
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      base

      # System
      boot
      audio

      # Desktop
      greeter
    ];
  };
}
