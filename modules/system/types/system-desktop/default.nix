{self, ...}: {
  flake.modules.nixos.system-desktop = {
    imports = with self.modules.nixos; [
      system-cli

      # Desktop features
      sddm
      audio
      printing
    ];
  };
}
