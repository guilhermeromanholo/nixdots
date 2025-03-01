{
  parts.modules = {
    # My system NixOS custom
    # modules
    nixosModules = {
      system = import ./nixos/system;
    };
  };
}
