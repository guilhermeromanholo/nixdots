{ self, ... }:
{
  flake.modules.nixos.sunset = {
    imports = with self.modules.nixos; [
      workstation
      glhrm
      impermanence
    ];

    settings = {
      disk.size = "100%";
      disk.swap = "4G";
      disk.device = "/dev/vda";
    };
  };

  flake.nixosConfigurations.sunset = self.lib.mkNixos {
    name = "sunset";
    modules = [ self.modules.nixos.sunset ];
  };
}
