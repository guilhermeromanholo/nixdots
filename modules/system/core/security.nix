{
  flake.nixosModules.security = {
    security = {
      rtkit.enable = true;
      polkit.enable = true;
      sudo-rs.enable = true;
    };
  };
}
