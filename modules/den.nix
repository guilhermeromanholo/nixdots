{ den, ... }:
{
  den.default = {
    includes = [
      den.batteries.hostname
      den.batteries.define-user
    ];

    nixos.system.stateVersion = "26.11";
  };

  den.quirks = {
    theme.description = "Base16 scheme";
    persist.description = "Persisted files and dirs";
  };

  den.policies.bind-theme =
    { host, ... }:
    [ (den.lib.policy.pipe.from "theme" [ ]) ];

  den.schema.host.includes = [ den.policies.bind-theme ];
}
