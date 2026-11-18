{ self, ... }:
{
  flake.nixosModules.theming = {
    imports = with self.nixosModules; [
      gtk
    ];
  };
}
