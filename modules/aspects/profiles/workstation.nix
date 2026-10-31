{ den, ... }:
{
  den.aspects.workstation = {
    includes = [
      # Profile
      den.aspects.core

      # Hardware
      den.aspects.ssd
      den.aspects.graphics
      den.aspects.firmware
    ];
  };
}
