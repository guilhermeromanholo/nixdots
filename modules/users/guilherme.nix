{self, ...}: {
  flake.modules.nixos.guilherme = {pkgs, ...}: {
    imports = [
      (self.factory.user {
        admin = true;
        shell = pkgs.fish;
        name = "guilherme";
      })
    ];

    # TODO: Migrate to nix-maid
    users.users.guilherme.packages = with pkgs; [
      git
      helix
    ];
  };
}
