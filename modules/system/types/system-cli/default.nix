{self, ...}: {
  flake.modules.nixos.system-cli = {
    imports = with self.modules.nixos; [
      system-base

      # TODO: Add cli features
    ];
  };
}
