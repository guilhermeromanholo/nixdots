{
  flake.modules.nixos.network = { config, ... }: {
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

    users.users.${config.settings.user.name} = {
      extraGroups = [ "networkmanager" ];
    };

    persist.root.directories = [
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
    ];
  };
}
