{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.theming = {config, ...}: {
    imports = [
      inputs.base16.nixosModule
    ];

    options.theme = lib.mkOption {
      type = lib.types.attrs;
      default = inputs.self.themes.gruvbox;
    };

    config.scheme = config.theme.colors;
  };
}
