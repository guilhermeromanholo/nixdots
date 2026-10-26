{ self, ... }: {
  flake.wrappers.kitty =
    {
      config,
      wlib,
      pkgs,
      lib,
      ...
    }:
    let
      t = config.theme;
      slots = [
        "base00"
        "base08"
        "base0B"
        "base0A"
        "base0D"
        "base0E"
        "base0C"
        "base05"
        "base03"
        "base08"
        "base0B"
        "base0A"
        "base0D"
        "base0E"
        "base0C"
        "base07"
      ];
    in
    {
      imports = [
        wlib.wrapperModules.kitty
        self.modules.generic.wrapper-theme
      ];
      font = {
        name = t.fonts.monospace;
        size = t.fonts.size;
      };
      settings = {
        shell = "${lib.getExe pkgs.nixdots.fish} --login";
        shell_integration = "enabled";
        enable_audio_bell = false;
        allow_hyperlinks = true;
        background_opacity = t.opacity;
        background = t.semantic.background;
        foreground = t.semantic.foreground;
        cursor = t.semantic.accent;
        selection_background = t.colors.base02;
        selection_foreground = t.semantic.foreground;
      }
      // builtins.listToAttrs (
        lib.imap0 (i: slot: lib.nameValuePair "color${toString i}" t.colors.${slot}) slots
      );
      filesToPatch = [
        "share/applications/kitty.desktop"
        "share/applications/kitty-open.desktop"
      ];
    };
  flake.modules.nixos.kitty = { config, pkgs, ... }: {
    users.users.${config.nixdots.user.name}.packages = [ pkgs.nixdots.kitty ];
  };
}
