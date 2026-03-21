{
  self,
  lib,
  ...
}: let
  name = "guilherme";
in {
  flake.homeConfigurations = self.lib.mkHomeManager name "x86_64-linux";

  flake.modules = lib.mkMerge [
    (self.factory.user name)

    {
      # NixOS
      nixos.${name} = {
        users.users.${name} = {
          extraGroups = ["networkmanager" "wheel"];
        };
      };

      # Home-Manager
      homeManager.${name} = {
        # ...
      };
    }
  ];
}
