{
  flake.wrappers.noctalia = { wlib, ... }: {
    imports = [ wlib.wrapperModules.noctalia ];
  };
}
