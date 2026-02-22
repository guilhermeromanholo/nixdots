{self, ...}: let
  stateVersion = "26.05";
in {
  flake.modules.nixos.system-base = {
    imports = with self.modules.nixos; [
      nix
      boot
      locale
      network
      firmware
    ];

    system.stateVersion = stateVersion;
  };

  flake.modules.homeManager.system-base = {
    home.stateVersion = stateVersion;
  };
}
