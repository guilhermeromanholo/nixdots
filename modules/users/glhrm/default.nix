{
  self,
  lib,
  ...
}: let
  name = "glhrm";
in {
  flake.modules = lib.mkMerge [
    (self.factory.user name true)

    {
      nixos.${name} = {config, ...}: {
        imports = [
          self.inputs.agenix.nixosModules.default
        ];

        age.identityPaths = ["/home/glhrm/.ssh/id_rsa"];
        age.secrets.glhrm-pass.file = self + /secrets/glhrm-pass.age;
        users.users.${name}.hashedPasswordFile = config.age.secrets.glhrm-pass.path;
      };

      homeManager.${name} = {
        imports = with self.modules.homeManager; [
          nh
          git
        ];

        programs.git.settings.user = {
          name = "guilhermeromanholo";
          email = "guilhermeromanholo@users.noreply.github.com";
        };
      };
    }
  ];
}
