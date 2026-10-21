{ self, inputs, ... }: {
  flake.modules.nixos.taz = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      workstation
      uefi
      printing
      inputs.disko.nixosModules.disko
      ../../hardware/taz/hardware.nix
      ../../hardware/taz/disko.nix
    ];
    networking.hostName = "taz";
    system.stateVersion = "24.11";
    nixdots.theme = self.themes.nord;
    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
    virtualisation = {
      docker.enable = true;
      libvirtd = {
        enable = true;
        qemu.swtpm.enable = true;
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      virtio-win
      win-spice
      docker-compose
    ];
  };
}
