{
  self,
  lib,
  ...
}: {
  flake.themes =
    lib.mapAttrs
    (name: _: import (self + /themes/${name}/theme.nix))
    (builtins.readDir (self + /themes));
}
