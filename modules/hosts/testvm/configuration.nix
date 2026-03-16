{self, ...}: {
  flake.modules.nixos.testvm = {
    imports = with self.modules.nixos; [
      # Roles
      desktop
    ];
  };
}
