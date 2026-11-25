{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      # System
      boot
      audio
      theme
      default
      network
      options

      # Features
      mango
      kitty
      greeter
    ];
  };
}
