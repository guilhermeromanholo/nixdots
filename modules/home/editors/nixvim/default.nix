{
  inputs,
  outputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.editors.nixvim;
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  options.modules.editors.nixvim = {
    enable = lib.mkEnableOption "Vim";
  };

  config = lib.mkIf cfg.enable {
    programs.  
        nixvim = lib.mkMerge [
      {enable = true;}
      outputs.nixvimModules.default
    ];
  };
}
