{inputs, ...}: {
  flake.lib.mkIfPersistence = config: settings:
    if config.environment ? persistence
    then {persistence."/persist" = settings;}
    else {};

  flake.modules.nixos.impermanence = {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
      enable = true;
      hideMounts = true;

      directories = [
        "/var/log"
        "/var/lib/nixos"
      ];

      files = ["etc/machine-id"];
    };
  };
}
