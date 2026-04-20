{self, ...}: {
  flake.modules.homeManager.niri = {pkgs, ...}: {
    imports =
      (with self.modules.homeManager; [
        noctalia
      ])
      ++ (with pkgs; [
        xwayland-satellite
      ]);
  };
}
