{ self, inputs, ... }: {
  flake.modules.nixos.sunset = {
    imports = with self.modules.nixos; [
      workstation
      uefi
      printing
      persistence
      vesktop
      inputs.disko.nixosModules.disko
      ./hardware.nix
      ./disko.nix
    ];
    networking.hostName = "sunset";
    system.stateVersion = "24.11";
    nixdots.theme = self.themes.gruvbox;
    boot.loader.grub.useOSProber = true;
    nixdots.persistence = {
      enable = true;
      systemDirectories = [ "/var/lib/tailscale" ];
      userDirectories = [
        ".ssh"
        ".mozilla"
        ".nixdots"
        "Documentos"
        ".config/vesktop"
      ];
      userFiles = [ ".gitconfig" ];
    };
  };
}
