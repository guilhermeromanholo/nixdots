{ self, ... }:
{
  flake.aspects.laptop = {
    includes = with self.aspects; [
      desktop
      battery
      bluetooth
    ];
  };
}
