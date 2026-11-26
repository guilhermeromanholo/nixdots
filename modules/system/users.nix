{ lib, ... }:
{
  flake.nixosModules.user-options.key = "nixdots:modules/system/users.nix:user-options";
  flake.nixosModules.user-options.options.settings.user = {
    name = lib.mkOption {
      type = lib.types.nonEmptyStr;
      default = "glhrm";
      description = "Primary local user.";
    };
    shell = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = null;
      description = "Login shell, also used by the configured terminal when set.";
    };
  };

  flake.nixosModules.users = { config, ... }: {

    key = "nixdots:modules/system/users.nix:users";
    users.users.${config.settings.user.name} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "password";
    }
    // lib.optionalAttrs (config.settings.user.shell != null) {
      shell = config.settings.user.shell;
    };
  };
}
