{self, ...}: {
  flake.modules.nixos.base = {
    imports = with self.modules.nixos; [
      nix
      boot
      locale
      network
      settings
    ];
  };
}
