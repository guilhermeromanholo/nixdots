{
  flake.nixosModules.networking = { config, ... }: {
    key = "nixdots:modules/system/networking.nix:networking";
    users.users.${config.settings.user.name}.extraGroups = [ "networkmanager" ];
    networking = {
      networkmanager = {
        enable = true;
        dns = "none";
      };

      nameservers = [
        "9.9.9.9"
        "149.112.112.112"
      ];
    };

    persist.root.directories = [
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
