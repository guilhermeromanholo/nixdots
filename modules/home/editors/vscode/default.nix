{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.vscode;
in {
  options.modules.editors.vscode = {
    enable = lib.mkEnableOption "Vscode";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      clang-tools
    ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      profiles.default = {
        extensions = with pkgs.vscode-extensions;
          [
            ms-pyright.pyright
            # ms-python.python
            vscodevim.vim
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "symbols";
              publisher = "miguelsolorio";
              version = "0.0.23";
              sha256 = "sha256-EoYi/x29kHiOWbYPPYZTwgdV1uLWKm85BVvhkQO5gyY=";
            }
          ];

        keybindings = [
          {
            key = "alt+enter";
            command = "workbench.action.terminal.toggleTerminal";
          }
          {
            key = "alt+q";
            command = "workbench.action.quickOpenView";
          }
        ];

        userSettings = {
          "workbench.iconTheme" = "symbols";
          "editor.lineHeight" = 1.8;
          "editor.rulers" = [80 120];
          "editor.renderLineHighlight" = "gutter";
          "editor.fontLigatures" = true;
          "workbench.editor.labelFormat" = "short";
          "breadcrumbs.enabled" = false;
          "workbench.activityBar.location" = "hidden";
          "editor.minimap.enabled" = false;
          "editor.scrollbar.vertical" = "hidden";
          "editor.scrollbar.horizontal" = "hidden";
          "workbench.statusBar.visible" = false;
          "window.commandCenter" = false;
          "workbench.layoutControl.enabled" = false;
          "explorer.fileNesting.enabled" = true;
          "window.menuBarVisibility" = "hidden";
        };
      };
    };
  };
}
