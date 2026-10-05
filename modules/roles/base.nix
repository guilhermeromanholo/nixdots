{self, ...}: {
  flake.modules.nixos.base = {
    imports = with self.modules.nixos; [
      nix
      user
      locale
      network
      firmware
    ];
  };
}
