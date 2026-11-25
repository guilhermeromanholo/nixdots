{ inputs, ... }:
{
  flake.nixosConfigurations.sunset = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.nixosModules; [
      sunset
      desktop
    ];
  };
}
