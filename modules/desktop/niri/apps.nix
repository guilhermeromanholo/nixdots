{self, ...}: {
  flake.modules.homeManager.niri = {
    imports = with self.modules.homeManager; [
      kitty
      noctalia
    ];
  };
}
