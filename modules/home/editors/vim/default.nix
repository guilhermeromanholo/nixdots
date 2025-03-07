{
  lib,
  config,
  options,
  outputs,
  ...
}: let
  cfg = config.modules.editors.vim;
in {
  options.modules.editors.vim = {
    enable = lib.mkEnableOption "Vim";
  };

  config = lib.mkIf cfg.enable {
    programs =
      if (options.programs ? nixvim)
      # Use nixvim if module is active and
      # merge with custom nixvim
      then {
        nixvim = lib.mkMerge [
          {enable = true;}
          (lib.optionalAttrs (outputs ? nixvimModule) (outputs.nixvimModule))
        ];
      }
      # Use default neovim package
      else {
        neovim.enable = true;
      };
  };
}
