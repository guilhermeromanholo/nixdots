{ self, ... }:
{
  flake.nixosModules.mango-noctalia = { config, ... }: {
    key = "nixdots:modules/roles/mango-noctalia.nix:mango-noctalia";
    imports = with self.nixosModules; [
      mango
      noctalia
      kitty
    ];
    session.actions."terminal.open" = config.session.actions."kitty.open";
  };
}
