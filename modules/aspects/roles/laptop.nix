{ den, ... }:
{
  den.aspects.laptop = {
    includes = [
      den.aspects.desktop
      den.aspects.battery
      den.aspects.bluetooth
    ];
  };
}
