{ self, ... }:
{
  flake.nixosModules.default = { config, pkgs, ... }: {
    imports = with self.nixosModules; [
      zsh
    ];

    users.users.${config.settings.user.name} = {
      shell = pkgs.my.zsh;
      isNormalUser = true;

      extraGroups = [
        "wheel"
        "networkmanager"
      ];

      initialPassword = "password";
    };
  };
}
