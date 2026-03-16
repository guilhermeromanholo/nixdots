{
  self,
  lib,
  ...
}: let
  name = "guilherme";
in {
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
