{inputs, ...}: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos {
    name = "taz";
    system = "x86_64-linux";
  };

  flake.modules.nixos.taz = {
    imports = with inputs.self.modules.nixos; [
      desktop
      guilherme
    ];
  };
}
