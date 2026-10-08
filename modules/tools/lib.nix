{ inputs, lib, ... }:
let
  flib = (inputs.flake-aspects.lib lib);
in
{
  flake.lib.forward = {
    user = name: { class, aspect-chain }: {
      nixos = { pkgs, ... }: {
        users.users.${name} = { ... }: {
          imports = [ (flib.resolve "user" [ ] (lib.head aspect-chain)) ];
          _module.args.pkgs = pkgs;
        };
      };
    };
  };
}
