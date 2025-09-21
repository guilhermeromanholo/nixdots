{
  options.modules.printer = {
    drivers = lib.mkOption {
      type = lib.types.listOf lib.types.package;
    };
  };
}
