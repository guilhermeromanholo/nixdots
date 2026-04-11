{self, ...}: {
  flake.modules.nixos.system-laptop = {
    imports = with self.modules.nixos; [
      system-desktop

      battery
      bluetooth
    ];
  };
}
