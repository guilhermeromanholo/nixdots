{ den, ... }:
{
  den.aspects.headless = {
    includes = [
      den.aspects.nix
      den.aspects.locale
      den.aspects.network
    ];
  };
}
