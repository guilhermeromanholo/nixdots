{self, ...}: {
  hosts.nixos.tesla = {
    version = "26.11";
    arch = "x86_64-linux";

    module.imports = with self.modules.nixos; [
      laptop
    ];
  };
}
