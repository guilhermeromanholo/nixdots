{ inputs, ... }:
{
  flake.nixosConfigurations.taz = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.nixosModules; [
      taz
      desktop
    ];
  };
}
