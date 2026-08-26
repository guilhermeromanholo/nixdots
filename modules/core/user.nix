{lib, ...}: {
  flake.factory.user = {
    name,
    admin,
    shell,
  }: {
    users.users.${name} = {
      isNormalUser = true;
      initialPassword = "password";

      inherit shell;
      ignoreShellProgramCheck = true;

      extraGroups = lib.optionals admin [
        "wheel"
        "networkmanager"
      ];
    };
  };
}
