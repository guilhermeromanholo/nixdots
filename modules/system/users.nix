{
  lib,
  self,
  ...
}: {
  flake.modules.nixos.users = {config, ...}:
    self.lib.mkModule {
      users.users.${config.settings.user.name} = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        initialPassword = "password";
      };
    };

  flake.modules.nixos.options = {
    options.settings.user.name = lib.mkOption {
      type = lib.types.str;
      default = "glhrm";
    };
  };
}
