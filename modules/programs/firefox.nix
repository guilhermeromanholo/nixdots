{
  flake.nixosModules.firefox = { pkgs, ... }: {
    key = "nixdots:modules/programs/firefox.nix:firefox";
    environment.systemPackages = [ pkgs.firefox ];
  };
}
