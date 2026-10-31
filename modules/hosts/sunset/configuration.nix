{ den, ... }:
{
  den.aspects.sunset = {
    includes = [
      # Profile
      den.aspects.core
    ];

    # ...
  };

  den.hosts.x86_64-linux.sunset = {
    users.guilherme = { };
  };
}
