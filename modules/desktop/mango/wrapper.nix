{ self, lib, ... }:
{
  flake.wrappers.mango =
    {
      wlib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        wlib.wrapperModules.mangowc
        self.lib.mkThemeOption
        self.lib.mkSessionOption
      ];
      package = pkgs.mango;
      settings =
        import ./_settings.nix
        // import ./_bindings.nix {
          inherit lib;
          inherit (config) session;
          sessionLib = self.lib.session;
        };
      autostart_sh = lib.concatMapStringsSep "\n" (
        argv: "${lib.escapeShellArgs argv} &"
      ) config.session.autostart;
    };
}
