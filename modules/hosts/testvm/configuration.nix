{self, ...}: {
  flake.modules.nixos.testvm = {
    imports = with self.modules.nixos; [
      system-desktop
    ];
  };
}
