{self, ...}: {
  flake.modules.nixos.guilherme = {
    pkgs,
    config,
    ...
  }: {
    imports = with self.modules.nixos; [
      fish
      helix
    ];

    users.users.guilherme = {
      shell = pkgs.fish;
      isNormalUser = true;

      extraGroups = self.lib.ifGroupExists config [
        "wheel"
        "networkmanager"
      ];

      initialPassword = "password";
    };
  };

  flake.modules.hjem.guilherme = {pkgs, ...}: {
    imports = with self.modules.hjem; [
      fish
      helix
    ];

    packages = with pkgs; [git];

    files.".gitconfig".text = ''
      [user]
        name = guilhermeromanholo
        email = guilhermeromanholo@users.noreply.github.com
    '';
  };
}
