{ self, ... }:
{
  flake.aspects.vortex = {
    includes = with self.aspects; [
      wsl
      base
      guilherme
    ];

    nixos = {
      wsl.defaultUser = "guilherme";
      nixpkgs.hostPlatform = "x86_64-linux";
    };
  };
}
