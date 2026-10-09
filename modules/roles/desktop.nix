{ self, moduleWithSystem, ... }:
{
  flake.aspects.desktop = {
    includes = with self.aspects; [
      base
      boot
      audio
      greeter
      firmware
    ];

    nixos = moduleWithSystem (
      { self' }: {
        programs.mango = {
          enable = true;
          package = self'.packages.mango;
        };
      }
    );
  };
}
