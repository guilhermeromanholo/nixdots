{self, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages = lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = self + /packages;
    };
  };
}
