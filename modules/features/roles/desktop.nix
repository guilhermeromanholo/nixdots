{ self, ... }:
{
  flake.aspects.desktop = {
    includes = with self.aspects; [
      base
      boot
      audio
      greeter
      firmware
    ];
  };
}
