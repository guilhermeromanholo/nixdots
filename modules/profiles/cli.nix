{self, ...}: {
  flake.modules.nixos.cli = {self', ...}: {
    imports = with self.modules.nixos; [
      nix
      locale
      network
    ];

    environment.systemPackages = [
      self'.packages.helix
    ];
  };
}
