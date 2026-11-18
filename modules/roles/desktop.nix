{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      # System
      core
      audio
      network
      options
      theming

      # Features
      # ...
    ];
  };
}
