{ moduleWithSystem, ... }: {
  flake.aspects.browser.nixos = moduleWithSystem (
    { inputs' }: {
      environment.systemPackages = [
        inputs'.zen-browser.packages.default
      ];
    }
  );
}
