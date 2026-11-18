{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      # Roles
      core

      # System
      audio
      theme
      network
      options

      # Features
      # ...
    ];
  };
}
