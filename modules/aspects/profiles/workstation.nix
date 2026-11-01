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

      # Services
      den.aspects.openssh
      den.aspects.printing
      den.aspects.tailscale

      # Desktop
      den.aspects.gtk
      den.aspects.mango
      den.aspects.greeter
    ];
  };
}
