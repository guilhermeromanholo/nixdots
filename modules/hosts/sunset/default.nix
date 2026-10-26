{ self, inputs, ... }: {
  flake.modules.nixos.sunset = { config, lib, ... }: {
    imports = with self.modules.nixos; [
      workstation
      uefi
      printing
      vesktop
      inputs.disko.nixosModules.disko
      ./_hardware.nix
      ./_disko.nix
    ];
    networking.hostName = "sunset";
    system.stateVersion = "24.11";
    nixdots.theme = self.themes.gruvbox;
    boot.loader.grub.useOSProber = true;
    nixdots.persistence.enable = true;
    environment.persistence."${config.nixdots.persistence.root}/system".directories = lib.mkAfter [
      "/var/lib/tailscale"
    ];
    environment.persistence.${config.nixdots.persistence.root}.users.${config.nixdots.user.name} = {
      directories = [
        ".ssh"
        ".mozilla"
        ".nixdots"
        "Documentos"
        ".config/vesktop"
      ];
      files = [ ".gitconfig" ];
    };
  };
}
