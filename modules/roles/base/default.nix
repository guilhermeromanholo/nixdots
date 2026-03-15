{self, ...}: let
  stateVersion = "26.05";
in {
  flake.modules.nixos.base = {
    imports = with self.modules.nixos; [
      # System
      nix
      boot
      locale
      network
      firmware

      # Tools
      home-manager
    ];

    system.stateVersion = stateVersion;

    home-manager.sharedModules = [
      self.modules.homeManager.base
    ];
  };

  flake.modules.homeManager.base = {
    home.stateVersion = stateVersion;
  };
}
