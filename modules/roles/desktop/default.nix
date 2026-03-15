{self, ...}: {
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      cli

      # Desktop features
      audio
      printing
    ];
  };
}
