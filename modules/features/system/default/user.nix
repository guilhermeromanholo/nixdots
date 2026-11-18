{
  flake.nixosModules.default = { config, pkgs, ... }: {
    programs.fish.enable = true;

    users.users.${config.settings.user.name} = {
      shell = pkgs.fish;
      isNormalUser = true;

      extraGroups = [
        "wheel"
        "networkmanager"
      ];

      initialPassword = "password";
    };
  };
}
