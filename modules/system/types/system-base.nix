{self, ...}: {
  flake.modules.nixos.system-base = {
    imports = with self.modules.nixos; [
      nix
      locale
      network
    ];
  };
}
