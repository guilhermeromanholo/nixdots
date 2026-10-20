{ moduleWithSystem, ... }:
{
  flake.nixosModules.fish = moduleWithSystem (
    { self', ... }:
    {
      programs.fish.enable = true;
      programs.fish.package = self'.packages.fish;
    }
  );
}
