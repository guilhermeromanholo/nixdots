{ inputs, den, ... }:
{
  imports = [ inputs.den.flakeModule ];

  den.default.includes = [
    den.batteries.hostname
    den.batteries.define-user
  ];

  den.default = {
    nixos.system.stateVersion = "26.11";
  };

  den.quirks = {
    secrets.description = "Agenix system secrets";
    persist.description = "System paths persisted on /persist";
  };
}
