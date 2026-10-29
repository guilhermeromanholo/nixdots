{
  den.aspects.system.security = {
    nixos.security = {
      rtkit.enable = true;
      polkit.enable = true;
      sudo-rs.enable = true;
    };
  };
}
