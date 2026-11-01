{ config, ... }:
let
  theme-default = config.themes.gruvbox;
in
{
  den.aspects.kitty.user = { pkgs, ... }: {
    packages = [ pkgs.my.kitty ];
  };

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
      imports = [ wlib.wrapperModules.kitty ];

      options.theme = lib.mkOption {
        default = theme-default;
        type = lib.types.attrs;
      };

      config = {
        runtimePkgs = with pkgs; [
          nerd-fonts.jetbrains-mono
        ];

        font = {
          name = "JetBrainsMono Nerd Font";
          size = 12;
        };

        settings = {
          shell = "${lib.getExe pkgs.fish} --login";
          shell_integration = "enabled";
          enable_audio_bell = false;
          allow_hyperlinks = true;
          background_opacity = 0.5;
          background = t.colors.base00;
          foreground = t.colors.base05;
          cursor = t.colors.base0D;
          selection_background = t.colors.base02;
          selection_foreground = t.colors.base05;
        }
        // builtins.listToAttrs (
          lib.imap0 (i: slot: lib.nameValuePair "color${toString i}" t.colors.${slot}) slots
        );
      };
    };
}
