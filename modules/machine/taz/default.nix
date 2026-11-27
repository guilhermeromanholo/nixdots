{ inputs, self, ... }:
{
  flake.nixosConfigurations.taz = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      taz-hardware
      workstation
      mango-noctalia
      {
        networking.hostName = "taz";
        system.stateVersion = "26.11";
      }
    ];
  };
}
