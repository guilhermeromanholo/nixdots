{ den, ... }:
{
  den.aspects.sunset = {
    includes = [
      # Profile
      den.aspects.workstation

      # Hardware
      den.aspects.disko
    ];
  };

  den.hosts.x86_64-linux.sunset = {
    disk.swap = "12G";
    disk.device = "/dev/nvme0n1";

    users.guilherme = { };
  };
}
