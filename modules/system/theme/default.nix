{ self, ... }:
{
  flake.nixosModules.theme = {
    imports = with self.nixosModules; [
      gtk
    ];
  };
}
