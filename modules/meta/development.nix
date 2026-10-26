{
  perSystem = { pkgs, lib, ... }: {
    devShells = {
      default = pkgs.mkShell {
        packages = [
          pkgs.nixfmt
          pkgs.statix
          pkgs.deadnix
        ];
      };
      java = pkgs.mkShell {
        packages = [
          pkgs.jdk
          pkgs.maven
          pkgs.python3
        ];
      };
      poetry = pkgs.mkShell {
        packages = [
          pkgs.poetry
          pkgs.python312
        ];
        LD_LIBRARY_PATH = lib.makeLibraryPath [
          pkgs.stdenv.cc.cc.lib
          pkgs.zlib
        ];
      };
    };
  };
}
