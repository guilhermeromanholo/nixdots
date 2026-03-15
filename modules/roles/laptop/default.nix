{self, ...}: {
  flake.modules.nixos.laptop = {
    imports = with self.modules.nixos; [
      desktop

      # Laptop features
      bluetooth
    ];
  };
}
