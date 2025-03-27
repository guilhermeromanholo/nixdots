{
  inputs,
  lib,
  config,
  ...
}: {
  options.parts.overlays = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "Custom overlays";
  };

  config = {
    flake.overlays = config.parts.overlays;

    perSystem = {system, ...}: {
      _module.args = import inputs.nixpkgs {
        inherit system;
        overlays = lib.attrValues config.parts.overlays;
      };
    };
  };
}
