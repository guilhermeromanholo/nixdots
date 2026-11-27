{lib, ...}: {
  flake.modules.wrappers.theme = {
    # TODO: Temp placeholder
    options.theme = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = {};
    };
  };
}
