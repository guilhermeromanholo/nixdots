{
  inputs,
  self,
  ...
}: {
  flake.modules = {
    nixos.niri = {pkgs, ...}: {
      programs.niri = {
        enable = true;
      };

      xdg.portal = {
        enable = true;

        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
        ];
      };

      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];

      home-manager.sharedModules = [
        self.modules.homeManager.niri
        {imports = [inputs.niri.homeModules.niri];}
      ];
    };

    homeManager.niri = {
      programs.niri.enable = true;

      imports = with self.modules.homeManager; [
        kitty
        noctalia
      ];
    };
  };
}
