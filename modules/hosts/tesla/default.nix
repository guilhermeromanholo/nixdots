{ inputs, self, ... }:
{
  flake.nixosConfigurations.tesla = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      tesla-hardware
      laptop
      mango-noctalia
      firefox
      {
        networking.hostName = "tesla";
        system.stateVersion = "26.05";
        settings.user.name = "guilherme";
      }
    ];
  };
}
