{self, ...}: {
  flake.modules.nixos.system-desktop = {
    imports = with self.modules.nixos; [
      system-cli

      boot
      firmware

      sddm
      audio
      printing

      disko
      impermanence
    ];
  };
}
