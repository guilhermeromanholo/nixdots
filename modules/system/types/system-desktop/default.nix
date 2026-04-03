{self, ...}: {
  flake.modules.nixos.system-desktop = {
    imports = with self.modules.nixos; [
      system-cli

      # Desktop
      sddm
      audio
      printing

      # Tools
      disko
    ];
  };
}
