{ self, ... }: {
  flake.wrappers.vesktop = { wlib, pkgs, ... }: {
    imports = [
      wlib.modules.default
      self.modules.generic.wrapper-theme
    ];
    package = pkgs.vesktop.override { withSystemVencord = true; };
    env.NIXOS_OZONE_WL = "1";
    filesToPatch = [ "share/applications/vesktop.desktop" ];
  };
  flake.modules.nixos.vesktop = { config, pkgs, ... }: {
    users.users.${config.nixdots.user.name}.packages = [ pkgs.nixdots.vesktop ];
  };
}
