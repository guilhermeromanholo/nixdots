{
  modules = {
    system = {
      # Enable boot, localtime, nix
      # and network-manager
      enable = true;

      # Configure bios boot grub
      # default device
      boot.device = "nodev";

      # Configure locale and
      # keymap settings
      localtime = {
        locale = "pt_BR.UTF-8";
        timezone = "America/Sao_Paulo";
        keymap = "br-abnt2";
      };

      # Configure system users
      # settings
      users = {
        nixos = {
          shell = "fish";
          groups = ["wheel" "networkmanager"];
        };
      };

      # Enable Home Manager as
      # NixOS module to specified users
      hm = {
        enable = true;
        modules = [./home.nix];
      };
    };
  };
}
