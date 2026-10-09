{ self, ... }:
{
  flake.aspects.base = {
    includes = with self.aspects; [
      nix
      locale
      network
    ];

    nixos.system.stateVersion = "26.11";
  };
}
