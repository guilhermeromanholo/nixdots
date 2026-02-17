{self, ...}: {
  flake.modules.nixos.constants = {config, ...}: {
    options.constants = {
      # Network
      hostname = self.lib.mkOpt "str" "nixos";

      # Locale
      locale = self.lib.mkOpt "str" "pt_BR.UTF-8";
      timezone = self.lib.mkOpt "str" "America/Sao_Paulo";

      # Boot
      uefi = self.lib.mkOpt "bool" false;
      osProber = self.lib.mkOpt "bool" false;
      bootDevice = self.lib.mkOpt "str" "nodev";
    };
  };
}
