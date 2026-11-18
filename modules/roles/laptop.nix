{ self, ... }:
{
  flake.nixosModules.laptop = {
    imports = with self.nixosModules; [
      # Role
      desktop

      # System
      battery
      bluetooth

      # Features
      # ...
    ];
  };
}
