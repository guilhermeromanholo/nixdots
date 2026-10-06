{ den, ... }:
{
  den.aspects.desktop = {
    includes = [
      den.aspects.base
      den.aspects.boot
      den.aspects.audio
      den.aspects.greeter
      den.aspects.firmware
    ];
  };
}
