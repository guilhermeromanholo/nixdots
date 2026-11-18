{
  flake.nixosModules.default = {
    time.timeZone = "America/Sao_Paulo";
    i18n.defaultLocale = "pt_BR.UTF-8";
  };
}
