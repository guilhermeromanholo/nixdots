{inputs, ...}: {
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
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"
      ];

      files = ["etc/machine-id"];
    };
  };
}
