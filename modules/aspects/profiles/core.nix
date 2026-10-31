{ den, ... }:
{
  den.aspects.core = {
    includes = [
      # Default
      den.aspects.nix
      den.aspects.boot
      den.aspects.locale
      den.aspects.nixpkgs
      den.aspects.network
      den.aspects.security
    ];
  };
}
