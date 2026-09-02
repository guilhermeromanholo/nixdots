{self, ...}: {
  flake.modules.nixos.guilherme = {pkgs, ...}: {
    imports = [
      (self.factory.user {
        admin = true;
        shell = pkgs.fish;
        name = "guilherme";
      })
    ];

    users.users.guilherme = {
      extraGroups = self.lib.mkIfGroupExists [
        "docker"
        "libvitd"
      ];

      packages = with pkgs; [
        git
        helix
      ];
    };
  };
}
