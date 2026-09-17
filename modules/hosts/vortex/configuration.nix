{self, ...}: {
  flake.modules.nixos.vortex = {
    imports = with self.modules.nixos; [
      # Role
      cli

      # Tools
      wsl

      # Users
      guilherme
    ];

    wsl.defaultUser = "guilherme";

    system.stateVersion = "26.11";
    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
