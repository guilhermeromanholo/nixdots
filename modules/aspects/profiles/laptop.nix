{ den, ... }:
{
  den.aspects.laptop = {
    includes = [
      # Profile
      den.aspects.workstation

      # Hardware
      den.aspects.battery
      den.aspects.bluetooth
    ];
  };
}
