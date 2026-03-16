{
  self,
  lib,
  ...
}: {
  flake.nixosConfigurations.testvm = lib.nixosSystem {
    modules = [self.modules.nixos.testvm];
  };
}
