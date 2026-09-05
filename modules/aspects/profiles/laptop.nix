{self, ...}: {
  flake.modules.nixos.laptop = {
    imports = with self.modules.nixos; [
      # Profile
      desktop

      # Hardware
      battery
      bluetooth
    ];
  };
}
