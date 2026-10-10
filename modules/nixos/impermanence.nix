{ inputs, ... }: {
  flake.aspects.impermanence = {
    includes = with inputs; [
      self.lib.forward.persist
    ];

    nixos = {
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

        files = [ "etc/machine-id" ];
      };
    };
  };
}
