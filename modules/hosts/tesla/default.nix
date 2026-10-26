{ self, ... }: {
  flake.modules.nixos.tesla = { ... }: {
    imports = [ self.modules.nixos.laptop ];
    networking.hostName = "tesla";
    nixdots.theme = self.themes.gruvbox;
    # Set this only after checking the installed system, together with hardware.
    assertions = [
      {
        assertion = false;
        message = "Tesla pendente: importar hardware/discos reais e definir o system.stateVersion existente antes de ativar.";
      }
    ];
  };
}
