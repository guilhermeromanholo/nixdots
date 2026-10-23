{self, ...}: {
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      core
      boot
      audio
      firmware
    ];
  };
}
