{ den, ... }:
{
  den.aspects.guilherme = {
    includes = [ den.batteries.primary-user ];
    user = {
      initialPassword = "password";
    };
  };
}
