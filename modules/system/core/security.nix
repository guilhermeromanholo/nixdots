{
  flake.nixosModules.security = {
    security.polkit.enable = true;
    security.sudo-rs.enable = true;
  };
}
