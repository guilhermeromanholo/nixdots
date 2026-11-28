{ self, ... }:
{
  flake.lib.mkWrapper = name: module: { wlib, ... }: {
    imports = [
      # Module config
      module

      # Theme options shared across all
      # wrappers (to generate overlays)
      self.modules.wrappers.theme

      # Check if the wrapper have an oficial implementation
      # or use the default module
      (if wlib.wrapperModules ? ${name} then wlib.wrapperModules.${name} else wlib.modules.default)
    ];
  };
}
