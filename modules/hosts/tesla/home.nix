{self, ...}: {
  flake.modules.nixos.tesla.imports = [
    ({config, ...}:
      self.factory.hjem {
        inherit config;
        host = "tesla";
        users = ["guilherme"];
      })
  ];

  flake.modules.hjem.tesla = {
    imports = with self.modules.hjem; [
      # ...
    ];
  };
}
