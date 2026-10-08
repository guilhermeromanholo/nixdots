{ inputs, lib, moduleWithSystem, ... }:
{
  flake.aspects.mango.nixos = moduleWithSystem (
    {self'}: 
    {
      programs.mango = {
	enable = true;
	package = self'.packages.mango;
      };
    }
  );

  perSystem =
    { self', pkgs, ... }:
    let
      kitty = lib.getExe pkgs.kitty;
      noctalia = lib.getExe self'.packages.noctalia;
    in
    {
      packages.mango = inputs.wrappers.wrappers.mangowc.wrap {
        inherit pkgs;

        settings = {
          bind = [
            "Alt, Q, killclient"
            "Alt, Return, spawn, ${kitty}"
            "Alt, D, spawn, ${noctalia} msg panel-toggle launcher"
          ];
        };

        autostart_sh = "${noctalia} &";
      };
    };
}
