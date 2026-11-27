{
  flake.nixosModules.firefox = { pkgs, ... }: {
    key = "nixdots:modules/apps/firefox.nix:firefox";
    environment.systemPackages = [ pkgs.firefox ];
  };
}
