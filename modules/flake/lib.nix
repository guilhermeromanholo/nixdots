{
  flake.lib = {
    # Impermanence helper
    mkIfPersistence = config: settings:
      (if config.environment ? persistence then settings else { });
  };
}
