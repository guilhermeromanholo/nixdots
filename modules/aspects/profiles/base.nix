{self, ...}: {
  flake.modules.nixos.base = {
    imports = with self.modules.nixos; [
      nix
      locale
      network
    ];
  };
}
