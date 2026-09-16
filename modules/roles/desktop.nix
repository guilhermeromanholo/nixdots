{den, ...}: {
  den.aspects.desktop.includes = [
    # Role
    den.aspects.cli

    # System
    den.aspects.boot
    den.aspects.audio

    # Hardware
    den.aspects.ssd
    den.aspects.firmware

    # Services
    den.aspects.openssh
    den.aspects.printing
    den.aspects.tailscale
  ];
}
