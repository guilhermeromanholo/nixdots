{self, ...}: {
  flake.modules.nixos.laptop = {
    imports = with self.modules.nixos; [
      desktop
      battery
      bluetooth
    ];
  };
}
