{ self, lib, ... }:
let
  inherit (lib) mkOption types;
  bindingType = types.submodule {
    options = {
      modifiers = mkOption {
        type = types.listOf (
          types.enum [
            "SUPER"
            "SHIFT"
            "CTRL"
            "ALT"
          ]
        );
        default = [ ];
        apply = lib.unique;
        description = "Modifiers, independent of the compositor's spelling.";
      };
      key = mkOption {
        type = types.strMatching "[a-zA-Z0-9_]+";
        description = "XKB keysym name, such as Return, Escape or comma.";
      };
      action = mkOption {
        type = types.nullOr types.nonEmptyStr;
        default = null;
        description = "Registered action to execute; mutually exclusive with switchTo.";
      };
      switchTo = mkOption {
        type = types.nullOr types.nonEmptyStr;
        default = null;
        description = "Mode to enter; mutually exclusive with action.";
      };
      release = mkOption {
        type = types.bool;
        default = false;
        description = "Trigger on key release rather than key press.";
      };
    };
  };
  actionType = types.submodule {
    options = {
      argv = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Executable and arguments, escaped by the compositor adapter.";
      };
      mango = mkOption {
        type = types.nullOr types.nonEmptyStr;
        default = null;
        description = "Native Mango command; takes precedence over argv.";
      };
      sway = mkOption {
        type = types.nullOr types.nonEmptyStr;
        default = null;
        description = "Native Sway command; takes precedence over argv.";
      };
    };
  };
in
{
  flake.lib.types.sessionType = types.submodule {
    options = {
      compositor = mkOption {
        type = types.nullOr (
          types.enum [
            "mango"
            "sway"
          ]
        );
        default = null;
        description = "Selected compositor; selecting two compositors is an error.";
      };
      actions = mkOption {
        type = types.lazyAttrsOf actionType;
        default = { };
        description = "Actions contributed by applications, compositors and roles.";
      };
      bindings = mkOption {
        type = types.attrsOf (types.listOf bindingType);
        default = { };
        description = "Bindings grouped by named mode. The default mode always exists.";
      };
      commonBindings = mkOption {
        type = types.listOf bindingType;
        default = [ ];
        description = "Bindings available in every mode; conflicts with local bindings are rejected.";
      };
      autostart = mkOption {
        type = types.listOf (types.listOf types.str);
        default = [ ];
        description = "Commands started once when the graphical session starts.";
      };
    };
    config.bindings.default = [ ];
  };

  flake.lib.mkSessionOption = {
    options.session = mkOption {
      type = self.lib.types.sessionType;
      default = { };
      description = "Shared session actions, binding modes and startup commands.";
    };
  };

  flake.nixosModules.session-options = { config, ... }: {

    key = "nixdots:modules/desktop/session/schema.nix:session-options";
    imports = [ self.lib.mkSessionOption ];
    assertions = lib.optionals (config.session.compositor != null) (
      map (message: {
        assertion = false;
        inherit message;
      }) (self.lib.session.errors config.session.compositor config.session)
    );
  };
}
