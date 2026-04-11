{self, ...}: {
  flake.modules.nixos.system-desktop = {
    imports = with self.modules.nixos; [
      system-cli

      boot
      firmware

      ly
      audio
      printing

      disko
      impermanence
    ];
  };
}
