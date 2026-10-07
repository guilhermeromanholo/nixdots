{ den, ... }:
{
  den.hosts.x86_64-linux.vortex = {
    wsl.enable = true;
    users.guilherme = { };
  };

  den.aspects.vortex = {
    includes = [
      den.aspects.headless
      den.aspects.theme.gruvbox
    ];
  };
}
