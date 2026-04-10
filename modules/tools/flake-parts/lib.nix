{
  inputs,
  self,
  lib,
  ...
}: {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake.lib = {
    mkNixos = name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          self.modules.nixos.${name}
          {networking.hostName = name;}
        ];
      };
    };
  };
}
