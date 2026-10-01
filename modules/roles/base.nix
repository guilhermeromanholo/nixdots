{self, ...}: {
  flake.modules.nixos.base = {
    imports = with self.modules.nixos; [
      nix
      locale
      network
      firmware
    ];

    system.stateVersion = "26.11";
  };
}
