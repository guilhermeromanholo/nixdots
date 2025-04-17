{pkgs, ...}: {
  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "live-server";
      version = "v1.0.0";

      src = pkgs.fetchFromGitHub {
        owner = "barrett-ruth";
        repo = "live-server.nvim";
        rev = "3547fecc984dde6de20664058b028e5e94e9bc87";
        hash = "sha256-1uom+6Iz3DspfBJRWVwTU51fGI7njt1VDrXpk3HuwXI=";
      };
    })
  ];

  extraPackages = with pkgs; [
    nodePackages.live-server
  ];

  extraConfigLua = ''
    require('live-server').setup(opts)
  '';
}
