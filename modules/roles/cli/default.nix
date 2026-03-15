{self, ...}: {
  flake.modules.nixos.cli = {
    imports = with self.modules.nixos; [
      base

      # TODO: Add cli features
    ];
  };
}
