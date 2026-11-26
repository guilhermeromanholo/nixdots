{ inputs, self, ... }:
{
  perSystem =
    { lib, pkgs, ... }:
    let
      sessionFailures = import ../../tests/session.nix { inherit lib self; };
      themeFailures = import ../../tests/theme.nix { inherit lib self pkgs; };
      systemFailures = import ../../tests/system.nix { inherit inputs lib self; };
      check =
        name: failures:
        assert lib.assertMsg (failures == [ ]) (builtins.toJSON failures);
        pkgs.runCommand name { } "touch $out";
    in
    {
      checks = {
        session = check "session-contract" sessionFailures;
      }
      // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        theme = check "theme-propagation" themeFailures;
        system = check "system-integration" systemFailures;
      };
    };
}
