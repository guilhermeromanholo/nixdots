{
  flake.modules.homeManager.firefox = {
    pkgs,
    lib,
    ...
  }: {
    programs.firefox = let
      profiles = {
        Personal = {id = 0;};
        Work = {id = 1;};
      };
    in {
      enable = true;

      profiles =
        lib.mapAttrs (_: v: {
          inherit (v) id;

          settings = {
            "browser.startup.page" = 1;
            "sidebar.verticalTabs" = true;
            "browser.cache.disk.enable" = false;
          };

          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            ublock-origin
            owasp-penetration-testing-kit
          ];

          extraConfig = ''
            ${builtins.readFile "${pkgs.betterfox}/user.js"}
          '';
        })
        profiles;
    };
  };
}
