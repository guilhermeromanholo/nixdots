{
  flake.modules.nixos.user = {
    config,
    pkgs,
    ...
  }: {
    users.users.${config.custom.username} = {
      shell = pkgs.fish;

      extraGroups = [
        "wheel"
        "networkmanager"
      ];

      isNormalUser = true;
      initialPassword = "password";
    };

    programs.fish.enable = true;
  };
}
