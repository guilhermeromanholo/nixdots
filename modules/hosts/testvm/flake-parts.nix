{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.testvm = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.modules.nixos.testvm];
  };
}
