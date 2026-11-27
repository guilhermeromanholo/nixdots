{self, ...}: {
  flake.lib.mkModule = module: {
    imports = [
      # Module configuration
      module

      # Options shared across all modules
      # like persist, settings, ...
      self.modules.nixos.options
    ];
  };
}
