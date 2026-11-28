{ self, ... }:
{
  flake.nixosConfigurations.tesla = self.lib.mkNixos {
    name = "tesla";
    version = "26.11";
  };

  flake.modules.nixos.tesla = {
    imports = with self.modules.nixos; [
      laptop
    ];
  };
}
