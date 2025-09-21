{
  pkgs,
  perSystem,
  ...
}: perSystem.devshell.mkShell {
  name = "poetry";

  commands = [
    {package = pkgs.poetry;}
    {package = pkgs.python313;}
  ];

  env = let
    zlib = "${pkgs.zlib}/lib";
    stdlib = "${pkgs.stdenv.cc.cc.lib}/lib";
  in [
    {
      name = "LD_LIBRARY_PATH"; 
      value = "${stdlib}:${zlib}:$LD_LIBRARY_PATH";
    }
  ];
}
