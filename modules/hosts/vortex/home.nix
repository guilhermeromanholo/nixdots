{self, ...}: {
  flake.modules.nixos.vortex.imports = [
    ({config, ...}:
      self.factory.hjem {
        inherit config;
        host = "vortex";
        users = ["guilherme"];
      })
  ];
}
