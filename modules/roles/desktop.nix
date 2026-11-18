{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      # System
      core
      audio
      theme
      network
      options

      # Features
      # ...
    ];
  };
}
