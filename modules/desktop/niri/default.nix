{
  inputs,
  self,
  ...
}: {
  flake.modules = {
    nixos.niri = {
      programs.niri = {
        enable = true;
      };

      home-manager.sharedModules = [
        self.modules.homeManager.niri
      ];
    };

    homeManager.niri = {
      imports = [inputs.niri.homeModules.niri];
      programs.niri.enable = true;
    };
  };
}
