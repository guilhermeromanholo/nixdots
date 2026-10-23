{self, ...}: {
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      desktop
      battery
      bluetooth
    ];
  };
}
