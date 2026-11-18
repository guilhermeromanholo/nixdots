{ inputs, ... }:
{
  imports = [ inputs.wrappers.flakeModules.default ];

  systems = [ "x86_64-linux" ];

  perSystem = { system, pkgs, ... }: {
    formatter = pkgs.nixfmt-tree;

    # _module.args.pkgs = import inputs.nixpkgs {
    #   inherit system;
    #   overlays = [ inputs.self.lib.mkOverlays ];
    #  };
  };
}
