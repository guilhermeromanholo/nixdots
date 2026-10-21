{ self, inputs, ... }: {
  flake.modules.nixos.base =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        self.modules.nixos.user-contract
        self.modules.nixos.theme-contract
        self.modules.nixos.persistence-contract
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
      users.users.${config.nixdots.user.name} = {
        isNormalUser = true;
        home = config.nixdots.user.home;
        createHome = true;
        extraGroups = [ "wheel" ];
        # Existing account credentials are retained through mutableUsers/persistence.
        # New machines must provision a password or authorized key before activation.
      };
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
