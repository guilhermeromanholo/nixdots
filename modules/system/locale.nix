{
  flake.nixosModules.locale = {
    key = "nixdots:modules/system/locale.nix:locale";
    time.timeZone = "America/Sao_Paulo";
    i18n.defaultLocale = "pt_BR.UTF-8";
  };
}
