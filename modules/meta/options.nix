{lib, ...}: {
  options.configurations.nixos = with lib;
    mkOption {
      type = types.lazyAttrsOf (types.submodule {
        options = {
          system = mkOption {type = types.str;};
          version = mkOption {type = types.str;};
          module = mkOption {type = types.deferredModule;};
        };
      });
    };
}
