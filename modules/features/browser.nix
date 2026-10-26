{ self, ... }: {
  flake.wrappers.firefox =
    {
      wlib,
      pkgs,
      ...
    }:
    {
      imports = [
        wlib.modules.default
        self.modules.generic.wrapper-theme
      ];
      # Firefox's own wrapper supports policies without making profiles read-only.
      package = pkgs.firefox.override {
        extraPolicies = {
          DontCheckDefaultBrowser = true;
        };
      };
      env.MOZ_ENABLE_WAYLAND = "1";
      filesToPatch = [ "share/applications/firefox.desktop" ];
    };
  flake.modules.nixos.browser = { config, pkgs, ... }: {
    users.users.${config.nixdots.user.name}.packages = [ pkgs.nixdots.firefox ];
  };
}
