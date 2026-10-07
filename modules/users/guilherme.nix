{ inputs, den, ... }:
let
  gitconfig = {
    name = "guilhermeromanholo";
    email = "89668419+guilhermeromanholo@users.noreply.github.com";
  };
in
{
  den.aspects.guilherme = {
    includes = [
      den.aspects.helix
      den.batteries.primary-user
      (den.batteries.user-shell "fish")
    ];

    user =
      { pkgs, ... }:
      {
        packages = [
          (inputs.wrappers.wrappers.git.wrap {
            inherit pkgs;
            settings.user = gitconfig;
          })
        ];
      };
  };
}
