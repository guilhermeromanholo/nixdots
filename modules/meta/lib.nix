{ inputs, lib, ... }:
{
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib = {
    mkNixos =
      {
        name,
        system ? "x86_64-linux",
        version ? "26.11",
        modules ? [ ],
      }:
      inputs.nixpkgs.lib.nixosSystem {
        modules = [
          { networking.hostName = name; }
          { system.stateVersion = version; }
          { nixpkgs.hostPlatform = system; }
        ]
        ++ modules;
      };

    mkOverlay = final: _prev: {
      my = lib.mapAttrs (
        _: w:
        w.wrap {
          pkgs = final;
        }
      ) inputs.self.wrappers;
    };
  };
}
