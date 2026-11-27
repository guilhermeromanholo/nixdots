{ self, lib, ... }:
{
  flake.wrappers.sway =
    {
      wlib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        wlib.modules.default
        self.lib.wrapperModules.theme
        self.lib.wrapperModules.session
      ];
      package = pkgs.sway;
      flags."--config" = config.constructFiles.swayConfig.path;
      filesToPatch = [ "share/wayland-sessions/sway.desktop" ];
      passthru.providedSessions = [ "sway" ];
      meta.platforms = lib.platforms.linux;
      constructFiles.swayConfig = {
        relPath = "sway.conf";
        content =
          builtins.readFile ./_config/config
          + "\n"
          + import ./_palette.nix { inherit (config) theme; }
          + "\n"
          + import ./_bindings.nix {
            inherit lib;
            inherit (config) session;
            sessionLib = self.lib.session;
          }
          + "\n"
          + lib.concatMapStringsSep "\n" (argv: "exec ${lib.escapeShellArgs argv}") config.session.autostart;
      };
    };
}
