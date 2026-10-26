{ self, inputs, ... }: {
  flake.modules.nixos.base =
    {
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        self.modules.nixos.user
        self.modules.nixos.theme-options
        self.modules.nixos.persistence
        self.modules.nixos.packages
      ];
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      time.timeZone = "America/Sao_Paulo";
      time.hardwareClockInLocalTime = true;
      i18n.defaultLocale = "pt_BR.UTF-8";
      console.keyMap = "br-abnt2";
      nix = {
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          trusted-users = [
            "root"
            "@wheel"
          ];
          auto-optimise-store = true;
          flake-registry = "";
        };
        registry.nixpkgs.flake = inputs.nixpkgs;
        nixPath = [ "nixpkgs=flake:nixpkgs" ];
        optimise.automatic = true;
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 14d";
        };
      };
      programs.nix-ld.enable = true;
      environment.systemPackages = with pkgs; [
        wget
        curl
        ripgrep
        fd
      ];
      services = {
        openssh = {
          enable = true;
          settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = true;
          };
        };
        tailscale.enable = true;
      };
    };
  flake.modules.nixos.uefi = {
    boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };
  flake.modules.nixos.printing = { pkgs, ... }: {
    services.printing = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    hardware.sane.enable = true;
    environment.systemPackages = [ pkgs.system-config-printer ];
  };
}
