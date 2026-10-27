{
  flake.modules.nixos.user = {
    host,
    pkgs,
    ...
  }: {
    programs.fish.enable = true;

    users.users.${host.username} = {
      isNormalUser = true;

      extraGroups = [
        "wheel"
        "audio"
        "tailscale"
        "networkmanager"
      ];

      shell = pkgs.fish;
      initialPassword = "password";
    };
  };
}
