{self, ...}: let
  stateVersion = "26.05";
in {
  flake.modules.nixos.system-base = {
    imports = with self.modules.nixos; [
      # Settings
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
      self.modules.homeManager.system-base
    ];
  };

  flake.modules.homeManager.system-base = {
    home.stateVersion = stateVersion;
  };
}
