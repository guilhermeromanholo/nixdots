{pkgs, ...}: {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "guess-indent.nvim";
      version = "1.0";
      src = pkgs.fetchFromGitHub {
        owner = "NMAC427";
        repo = "guess-indent.nvim";
        rev = "6cd61f7a600bb756e558627cd2e740302c58e32d";
        hash = "sha256-mzX9LgG2+9aj2lMPlSZh3zP3wphHQdecXe7RHP1baT0=";
      };
    })
  ];

  extraConfigLua = ''
    require('guess-indent').setup({})
  '';
}
