{inputs, ...}: {
  perSystem = {config, ...}: {
    # Additional packages
    overlayAttrs = config.packages;
  };

  flake.overlays = {
    # Nix User Repository (NUR)
    nur = inputs.nur.overlays.default;

    # Packages modifications
    # https://nixos.wiki/wiki/overlays
    modifications = final: prev: {
      # ...
    };
  };
}
