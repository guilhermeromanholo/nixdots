{self, ...}: {
  flake.wrappers.zellij = {
    wlib,
    pkgs,
    ...
  }: {
    imports = [wlib.modules.default];

    config.package = pkgs.zellij;
    config.flags."--config" = self.lib.linkDots "zellij/config.kdl";
  };
}
