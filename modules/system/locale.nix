{self, ...}: {
  flake.modules.nixos.locale = self.lib.mkModule {
    time.timeZone = "America/Sao_Paulo";
    i18n.defaultLocale = "pt_BR.UTF-8";
  };
}
