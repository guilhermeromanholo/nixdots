{ self, ... }:
{
  flake.aspects.base = {
    includes = with self.aspects; [
      nix
      locale
      network
    ];
  };
}
