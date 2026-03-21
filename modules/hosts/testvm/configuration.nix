{self, ...}: {
  flake.nixosConfigurations = self.lib.mkNixos "testvm";

  flake.modules.nixos.testvm = {
    imports = with self.modules.nixos; [
      system-desktop

      sway
      openssh
    ];

    networking.hostName = "testvm";
  };
}
