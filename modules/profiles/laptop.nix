{self, ...}: {
  flake.modules.nixos.laptop = {
    imports = with self.modules.nixos; [
      # Role
      desktop

      # Hardware
      battery
      bluetooth
    ];
  };
}
