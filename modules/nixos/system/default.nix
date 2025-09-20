{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system;
in {
  imports = [./options.nix];

  # Boot
  boot.loader.grub = {
    enable = true;

    device = cfg.device;
    useOSProber = cfg.os-prober;

    efiSupport = cfg.uefi;
    efiInstallAsRemovable = cfg.uefi;
  };

  # Network
  networking = {
    hostName = cfg.hostname;
    networkmanager.enable = true;
  };

  # Localtime
  time.timeZone = cfg.timezone;
  i18n.defaultLocale = cfg.locale;

  i18n.extraLocaleSettings = {
    LANGUAGE = cfg.locale;
    LC_ALL = cfg.locale;
    LC_ADDRESS = cfg.locale;
    LC_IDENTIFICATION = cfg.locale;
    LC_MEASUREMENT = cfg.locale;
    LC_MONETARY = cfg.locale;
    LC_NAME = cfg.locale;
    LC_NUMERIC = cfg.locale;
    LC_PAPER = cfg.locale;
    LC_TELEPHONE = cfg.locale;
    LC_TIME = cfg.locale;
  };

  console.keyMap = cfg.keymap;

  # Users
  users.users = lib.mapAttrs (n: v: { 
    isNormalUser = true;
    extraGroups = v.groups;
    initialPassword = "password";

    shell = pkgs.${v.shell};
    ignoreShellProgramCheck = true;
  }) config.users;
}
