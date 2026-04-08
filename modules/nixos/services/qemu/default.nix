{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.services.qemu;
in {
  options.modules.services.qemu = {
    enable = lib.mkEnableOption "Qemu";
  };

  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      virtio-win
      win-spice
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
