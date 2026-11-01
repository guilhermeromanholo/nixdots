{ den, config, ... }:
{
  den.aspects.sunset = {
    includes = [
      # Profile
      den.aspects.workstation

      # Hardware
      den.aspects.disko
      den.aspects.impermanence
    ];
  };

  den.hosts.x86_64-linux.sunset = {
    disk.swap = "12G";
    disk.device = "/dev/nvme0n1";

    theme = config.themes.nord;

    users.guilherme = { };
  };
}
