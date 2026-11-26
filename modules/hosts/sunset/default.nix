{ inputs, self, ... }:
{
  flake.nixosConfigurations.sunset = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      sunset-hardware
      workstation
      mango-noctalia
      {
        networking.hostName = "sunset";
        system.stateVersion = "26.11";
      }
    ];
  };
}
