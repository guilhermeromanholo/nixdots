{ self, ... }:
{
  flake.nixosModules.options = {
    imports = with self.nixosModules; [
      persist
      settings
    ];
  };
}
