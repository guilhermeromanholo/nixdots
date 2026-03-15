{self, ...}: {
  flake.modules.nixos.system-desktop = {
    imports = with self.modules.nixos; [
      system-cli

      # Desktop features
      audio
      printing
    ];
  };
}
