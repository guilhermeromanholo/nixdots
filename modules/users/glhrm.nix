let
  name = "glhrm";
in
{
  flake.modules.nixos.${name} = { pkgs, ... }: {
    programs.fish.enable = true;

    users.users.${name} = {
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
