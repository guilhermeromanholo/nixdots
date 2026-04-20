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

      environment.systemPackages = with pkgs; [
	xwayland-satellite
      ];

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
