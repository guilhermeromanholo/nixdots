{self, ...}: {
  flake.lib.mkWrapper = name: module: {wlib, ...}: {
    imports = [
      # Check if the wrapper have an oficial implementation
      # or use the default module
      (
        if wlib.wrapperModules ? ${name}
        then wlib.wrapperModules.${name}
        else wlib.modules.default
      )

      # Module configuration
      module

      # Theme options shared across all
      # wrappers (to generate overlays)
      self.modules.wrappers.theme
    ];
  };
}
