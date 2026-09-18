{self, ...}: {
  flake.modules.nixos.cli = {
    imports = with self.modules.nixos; [
      nix
      locale
      network
    ];
  };
}
