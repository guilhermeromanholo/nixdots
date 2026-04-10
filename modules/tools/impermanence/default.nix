{inputs, ...}: {
  flake.modules.nixos.impermanence = {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist/system" = {
      hideMounts = true;

      files = [
	"/etc/shadow"
	"/etc/adjtime"
	"/etc/machine-id"
      ];

      directories = [
	"/var/lib/nixos"
	"/var/lib/NetworkManager"
	"/etc/NetworkManager/system-connections"
      ];
    };
  };
}
