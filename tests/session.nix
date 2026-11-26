{ lib, self }:
let
  normalize =
    session:
    (lib.evalModules {
      modules = [
        self.lib.mkSessionOption
        { inherit session; }
      ];
    }).config.session;

  fixture = normalize {
    actions.terminal.argv = [
      "/bin/kitty"
      "--title"
      "two words"
    ];
    commonBindings = [
      {
        modifiers = [ "SUPER" ];
        key = "r";
        action = "terminal";
      }
    ];
    bindings = {
      default = [
        {
          modifiers = [ "SUPER" ];
          key = "space";
          switchTo = "apps";
        }
      ];
      apps = [
        {
          key = "t";
          action = "terminal";
        }
        {
          key = "Escape";
          switchTo = "default";
        }
      ];
    };
  };
  mango = import ../modules/desktop/mango/_bindings.nix {
    inherit lib;
    sessionLib = self.lib.session;
    session = fixture;
  };
  sway = import ../modules/desktop/sway/_bindings.nix {
    inherit lib;
    sessionLib = self.lib.session;
    session = fixture;
  };
  invalid = session: self.lib.session.errors "sway" (normalize session) != [ ];
  aliasSession =
    (lib.evalModules {
      modules = [
        self.lib.mkSessionOption
        ({ config, ... }: {
          session.actions."terminal.open" = config.session.actions."kitty.open";
        })
        { session.actions."kitty.open".argv = [ "/bin/kitty" ]; }
      ];
    }).config.session;
in
lib.runTests {
  testValidForBothCompositors = {
    expr = map (backend: self.lib.session.errors backend fixture) [
      "mango"
      "sway"
    ];
    expected = [
      [ ]
      [ ]
    ];
  };
  testMangoModes = {
    expr = mango.key_mode;
    expected = {
      common = {
        bind = [ "SUPER,r,spawn,/bin/kitty --title 'two words'" ];
        bindr = [ ];
      };
      default = {
        bind = [ "SUPER,space,setkeymode,apps" ];
        bindr = [ ];
      };
      apps = {
        bind = [
          "NONE,t,spawn,/bin/kitty --title 'two words'"
          "NONE,Escape,setkeymode,default"
        ];
        bindr = [ ];
      };
    };
  };
  testSwayModesAndCommonBindings = {
    expr =
      lib.hasInfix "mode \"apps\" {" sway
      && lib.hasInfix "bindsym Escape mode \"default\"" sway
      && builtins.length (lib.splitString "bindsym Mod4+r " sway) == 3
      && lib.hasInfix "exec /bin/kitty --title 'two words'" sway;
    expected = true;
  };
  testActionAliases = {
    expr = aliasSession.actions."terminal.open".argv;
    expected = [ "/bin/kitty" ];
  };
  testMissingAction = {
    expr = invalid {
      bindings.default = [
        {
          key = "t";
          action = "missing";
        }
      ];
    };
    expected = true;
  };
  testMissingMode = {
    expr = invalid {
      bindings.default = [
        {
          key = "t";
          switchTo = "missing";
        }
      ];
    };
    expected = true;
  };
  testDuplicateBindings = {
    expr = invalid {
      bindings.default = [
        {
          modifiers = [
            "SUPER"
            "SHIFT"
          ];
          key = "t";
          switchTo = "default";
        }
        {
          modifiers = [
            "SHIFT"
            "SUPER"
          ];
          key = "T";
          switchTo = "default";
        }
      ];
    };
    expected = true;
  };
  testCommonBindingCollision = {
    expr = invalid {
      commonBindings = [
        {
          key = "Escape";
          switchTo = "default";
        }
      ];
      bindings.default = [
        {
          key = "Escape";
          switchTo = "default";
        }
      ];
    };
    expected = true;
  };
  testMissingTarget = {
    expr = invalid { bindings.default = [ { key = "t"; } ]; };
    expected = true;
  };
  testAmbiguousTarget = {
    expr = invalid {
      actions.terminal.argv = [ "/bin/kitty" ];
      bindings.default = [
        {
          key = "t";
          action = "terminal";
          switchTo = "default";
        }
      ];
    };
    expected = true;
  };
  testUnsupportedAction = {
    expr = invalid {
      actions.jump.mango = "togglejump";
      bindings.default = [
        {
          key = "t";
          action = "jump";
        }
      ];
    };
    expected = true;
  };
  testReservedMode = {
    expr = invalid { bindings.common = [ ]; };
    expected = true;
  };
  testReleaseBinding = {
    expr = (
      import ../modules/desktop/sway/_bindings.nix {
        inherit lib;
        sessionLib = self.lib.session;
        session = normalize {
          bindings.default = [
            {
              key = "Escape";
              release = true;
              switchTo = "default";
            }
          ];
        };
      }
    );
    expected = "bindsym --release Escape mode \"default\"";
  };
  testAdaptersRejectInvalidSession = {
    expr =
      (builtins.tryEval (
        import ../modules/desktop/sway/_bindings.nix {
          inherit lib;
          sessionLib = self.lib.session;
          session = normalize {
            bindings.default = [
              {
                key = "t";
                action = "missing";
              }
            ];
          };
        }
      )).success;
    expected = false;
  };
}
