{ self, ... }: {
  flake.wrappers.nh = { wlib, lib, ... }: {
    imports = [
      wlib.wrapperModules.nh
      self.modules.generic.wrapper-theme
    ];
    flake = lib.mkDefault "$HOME/.nixdots";
  };
  flake.modules.nixos.nh = { config, pkgs, ... }: {
    users.users.${config.nixdots.user.name}.packages = [ pkgs.nixdots.nh ];
  };
}
