{ self, lib, ... }:
{
  flake.wrappers.mango = { wlib, pkgs, ... }: {
    imports = [
      wlib.wrapperModules.mangowc
      self.lib.mkThemeOption
    ];

    package = pkgs.mango;

    autostart_sh = ''
      ${lib.getExe pkgs.my.noctalia} &
    '';

    settings = {
      bind = [
        "ALT, Return, spawn, ${lib.getExe pkgs.my.kitty}"
      ];
    };
  };
}
