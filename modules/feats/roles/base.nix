{self, ...}: {
  flake.modules.nixos.base = {
    imports = with self.modules.nixos; [
      # Core
      nix
      locale
      network
    ];
  };
}
