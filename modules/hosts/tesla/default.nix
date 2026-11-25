{ inputs, ... }:
{
  flake.nixosConfigurations.tesla = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.nixosModules; [
      tesla
      laptop
    ];
  };
}
