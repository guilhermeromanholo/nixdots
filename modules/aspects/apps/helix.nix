{ inputs, ... }:
{
  den.aspects.helix.nixos =
    { pkgs, ... }:
    let
      helix = (
        inputs.wrappers.wrappers.helix.wrap {
          inherit pkgs;
          # settings = import ./_settings.nix;
          # languages = import ./_languages.nix;
        }
      );
    in
    {
      environment.systemPackages = [ helix ];
    };
}
