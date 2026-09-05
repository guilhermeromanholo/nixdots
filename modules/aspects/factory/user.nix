{lib, ...}: {
  flake.factory.user = {
    name,
    admin,
    shell,
  }: {
    users.users.${name} = {
      isNormalUser = true;
      initialPassword = "password";

      extraGroups = lib.optionals admin [
        "wheel"
        "networkmanager"
      ];

      inherit shell;
      ignoreShellProgramCheck = true;
    };
  };

  flake.lib.ifGroupExists = config: groups:
    builtins.filter
    (g: builtins.hasAttr g config.users.groups)
    groups;
}
