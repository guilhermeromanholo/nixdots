{inputs, ...}: {
  den.aspects.impermanence.nixos = {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
      enable = true;
      hideMounts = true;

      files = [
        "etc/machine-id"
      ];

      directories = [
        "/var/log"
        "/var/lib/nixos"
      ];
    };
  };
}
