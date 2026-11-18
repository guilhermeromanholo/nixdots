{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      # System
      boot
      audio
      default
      network
      options
      theming

      # Features
      mango
      kitty
      greeter
    ];
  };
}
