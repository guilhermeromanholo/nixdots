{ inputs, lib, ... }:
let
  flib = (inputs.flake-aspects.lib lib);
in
{
  flake.lib.forward = {
    user = name: { aspect-chain, ... }: {
      nixos = { pkgs, ... }: {
        users.users.${name} = { ... }: {
          imports = [ (flib.resolve "user" [ ] (lib.head aspect-chain)) ];
          _module.args.pkgs = pkgs;
        };
      };
    };

    persist =
      { aspect-chain, ... }:
      flib.forward {
        each = [ true ];
        fromClass = _: "persist";
        intoClass = _: "nixos";
        intoPath = _: [
          "environment"
          "persistence"
          "/persist"
        ];
        fromAspect = _: lib.head aspect-chain;
      };
  };
}
