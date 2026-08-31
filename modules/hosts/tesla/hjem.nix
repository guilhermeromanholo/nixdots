{self, ...}: {
  flake.modules.nixos.tesla.imports = [
    (self.factory.hjem {
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
