{ self, ... }: {
  flake.wrappers.helix =
    {
      config,
      wlib,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        wlib.wrapperModules.helix
        self.modules.generic.wrapper-theme
      ];
      runtimePkgs = [
        pkgs.nixd
        pkgs.ty
      ];
      settings.theme = "nixdots";
      themes.nixdots = {
        inherits = if config.theme.name == "gruvbox" then "gruvbox" else "nord";
        "ui.background" = {
          bg = config.theme.semantic.background;
        };
        "ui.text" = {
          fg = config.theme.semantic.foreground;
        };
        "ui.selection" = {
          bg = config.theme.colors.base02;
        };
        "ui.statusline" = {
          fg = config.theme.semantic.foreground;
          bg = config.theme.semantic.surface;
        };
      };
      languages = {
        language-server = {
          nixd.command = lib.getExe pkgs.nixd;
          ty = {
            command = lib.getExe pkgs.ty;
            args = [ "server" ];
          };
        };
        language = [
          {
            name = "nix";
            language-servers = [ "nixd" ];
          }
          {
            name = "python";
            language-servers = [ "ty" ];
          }
        ];
      };
    };
  flake.modules.nixos.helix =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      users.users.${config.nixdots.user.name}.packages = [ pkgs.nixdots.helix ];
      environment.sessionVariables = {
        EDITOR = lib.getExe pkgs.nixdots.helix;
        VISUAL = lib.getExe pkgs.nixdots.helix;
      };
    };
}
