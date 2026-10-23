{self, ...}: {
  flake.modules.nixos.core = {
    imports = with self.modules.nixos; [
      nix
      user
      locale
      network
      contracts
    ];
  };
}
