{ self, ... }: {
  flake.modules.nixos.terminal = {
    imports = with self.modules.nixos; [
      base
      fish
      helix
      git
      nh
    ];
  };
  flake.modules.nixos.workstation = {
    imports = with self.modules.nixos; [
      terminal
      theme
      session
      mango
      noctalia
      kitty
      browser
    ];
    services.fstrim.enable = true;
  };
  flake.modules.nixos.laptop = { ... }: {
    imports = [ self.modules.nixos.workstation ];
    hardware.bluetooth.enable = true;
    # power-profiles-daemon is already owned by the Noctalia integration.
    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
