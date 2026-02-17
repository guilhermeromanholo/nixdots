{self, ...}: {
  flake.modules.nixos.system = {
    imports = with self.modules.nixos; [
      nix
      boot
      locale
      network
      constants
    ];
  };
}
