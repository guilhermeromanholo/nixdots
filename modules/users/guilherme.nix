{ inputs, den, ... }:
{
  den.aspects.guilherme = {
    includes = [
      den.aspects.helix
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
    ];

    user =
      { pkgs, ... }:
      let
        git = inputs.wrappers.wrappers.git.wrap {
          inherit pkgs;
          settings.user = {
            name = "guilhermeromanholo";
            email = "89668419+guilhermeromanholo@users.noreply.github.com";
          };
        };
      in
      {
        packages = [ git ];
      };
  };
}
