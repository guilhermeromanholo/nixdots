{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      # System
      core
      boot
      audio
      network
      options

      # Features
      # ...
    ];
  };
}
