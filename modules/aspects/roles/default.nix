{ den, ... }:
{
  den.aspects.roles.default = {
    includes = with den.aspects; [
      # System base aspects
      system.nix
      system.boot
      system.locale
      system.network
      system.nixpkgs
      system.security
    ];
  };
}
