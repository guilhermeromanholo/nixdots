{self, ...}: {
  flake.nixosConfigurations = self.lib.mkNixos "sunset";

  flake.modules.nixos.sunset = {
    imports = with self.modules.nixos; [
      # Type
      system-desktop

      # Services
      docker
      fstrim
      openssh
      tailscale
    ];
  };
}
