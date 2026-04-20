{self, ...}: {
  flake.modules.nixos.system-cli = {
    imports = with self.modules.nixos; [
      # Type
      system-base

      # TODO: Add cli features
    ];
  };
}
