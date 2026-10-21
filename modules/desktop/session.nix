{
  flake.modules.nixos.session =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      hardware.graphics.enable = true;
      networking.networkmanager.enable = true;
      users.users.${config.nixdots.user.name}.extraGroups = [ "networkmanager" ];
      security = {
        polkit.enable = true;
        rtkit.enable = true;
      };
      services = {
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };
        gnome.gnome-keyring.enable = true;
        greetd = {
          enable = true;
          settings.default_session = {
            command = "${lib.getExe pkgs.tuigreet} --time --remember --remember-user-session --asterisks --cmd ${lib.getExe pkgs.nixdots.mango}";
            user = "greeter";
          };
        };
      };
      security.pam.services.greetd.enableGnomeKeyring = true;
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      environment.systemPackages = with pkgs; [
        pavucontrol
        wl-clipboard
        brightnessctl
      ];
    };
}
