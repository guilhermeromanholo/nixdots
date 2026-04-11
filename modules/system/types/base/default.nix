{self, ...}: let
  stateVersion = "26.05";
in {
  flake.modules = {
    nixos.system-base = {
      imports = with self.modules.nixos; [
        nix
        locale
        network

        home-manager
      ];

      system.stateVersion = stateVersion;

      home-manager.sharedModules = [
        self.modules.homeManager.system-base
      ];
    };

    homeManager.system-base = {
      home.stateVersion = stateVersion;
    };
  };
}
