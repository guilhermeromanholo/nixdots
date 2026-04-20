{self, ...}: {
  flake.modules.homeManager.niri = {pkgs, ...}: {
    imports = [
      # Packages
      pkgs.xwayland-satellite

      # Modules
      self.modules.homeManager.noctalia
    ];
  };
}
