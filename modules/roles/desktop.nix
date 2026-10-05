{self, ...}: {
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      base
      boot
      audio
      greeter
    ];
  };
}
