{self, ...}: {
  flake.modules.nixos.system-laptop = {
    imports = with self.modules.nixos; [
      # Type
      system-desktop

      # Hardware
      battery
      bluetooth
    ];
  };
}
