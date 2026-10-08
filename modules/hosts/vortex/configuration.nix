{ self, ... }:
{
  flake.aspects.vortex = {
    includes = with self.aspects; [
      wsl
      base
      guilherme
    ];

    nixos.wsl.defaultUser = "guilherme";
    nixos.nixpkgs.hostPlatform = "x86_64-linux";
  };
}
