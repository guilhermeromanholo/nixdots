{self, ...}: {
  flake.modules = {
    nixos.system-desktop = {
      imports = with self.modules.nixos; [
        # Type
        system-cli

        # Settings
        boot
        firmware
        graphics

        # Services
        sddm
        audio
        printing

        # Tools
        disko
        impermanence
      ];

      home-manager.sharedModules = [
        self.modules.homeManager.system-desktop
      ];
    };

    homeManager.system-desktop = {
      imports = with self.modules.homeManager; [
        impermanence
      ];
    };
  };
}
