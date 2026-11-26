{ self, ... }:
{
  flake.wrappers.starship = { wlib, config, ... }: {
    imports = [
      wlib.wrapperModules.starship
      self.lib.mkThemeOption
    ];
    preset = [ "gruvbox-rainbow" ];
    settings = {
      palette = "custom";
      palettes.custom = import ./_palette.nix { inherit (config) theme; };
      docker_context.format = "[[ $symbol( $context) ](fg:color_blue bg:color_bg3)]($style)";
      conda.format = "[[ $symbol( $environment) ](fg:color_blue bg:color_bg3)]($style)";
    };
  };
}
