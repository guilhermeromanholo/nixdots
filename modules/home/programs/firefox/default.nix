{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.firefox;
in {
  options.modules.programs.firefox = {
    enable = lib.mkEnableOption "Firefox";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      # profiles.default = {
      #   search.default = "ddg";

      #   extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
      #     ublock-origin
      #     vimium
      #   ];

      #   settings = {
      #     "sidebar.verticalTabs" = true;

      #     "browser.uiCustomization.state" = ''            {
      #                   "placements": {
      #                     "widget-overflow-fixed-list":[],
      #                     "unified-extensions-area":[
      #                       "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action",
      #                       "ublock0_raymondhill_net-browser-action",
      #                       "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
      #                     ],
      #                     "nav-bar":[
      #                       "sidebar-button","back-button","stop-reload-button",
      #                       "forward-button","urlbar-container","vertical-spacer",
      #                       "unified-extensions-button"
      #                     ],
      #                     "toolbar-menubar":["menubar-items"],
      #                     "TabsToolbar":[],
      #                     "vertical-tabs":["tabbrowser-tabs"],
      #                     "PersonalToolbar":["import-button","personal-bookmarks"]
      #                   },
      #                   "seen": [
      #                     "save-to-pocket-button","developer-button",
      #                     "ublock0_raymondhill_net-browser-action",
      #                     "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action",
      #                     "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
      #                   ],
      #                   "dirtyAreaCache":[
      #                     "nav-bar","TabsToolbar","vertical-tabs","PersonalToolbar",
      #                     "toolbar-menubar","unified-extensions-area"
      #                   ],
      #                   "currentVersion":21,
      #                   "newElementCount":3
      #                 }'';
      #   };
      # };
    };
  };
}
