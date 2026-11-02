{ inputs, ... }:
{
  flake.modules.nixos.impermanence = {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
      hideMounts = true;

      # Persisted files in all
      # systems
      files = [
        "/etc/adjtime"
        "/etc/machine-id"
      ];

      # Persisted dirs in all
      # systems
      directories = [
        "/var/log"
        "/var/lib/nixos"
      ];
    };
  };
}
