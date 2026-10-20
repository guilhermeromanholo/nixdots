{ inputs, lib, ... }:
{
  flake.nixosModules.kitty = inputs.self.lib.mkModule (
    { self', ... }:
    {
      programs.kitty.enable = true;
      programs.kitty.package = self'.packages.kitty;
    }
  );

  perSystem = { pkgs, ... }: {
    packages.kitty = inputs.wrappers.wrappers.kitty.wrap {
      inherit pkgs;

      runtimePkgs = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      font = {
        size = 12;
        name = "JetBrainsMono Nerd Font";
      };

      settings = lib.mkMerge [
        {
          cursor_trail = 3;
          cursor_trail_decay = "0.1 0.4";

          enable_audio_bell = "no";
          confirm_os_window_close = 0;

          background_opacity = 0.5;
        }

        (import ./_colors.nix { inherit (inputs.self.theme) colors; })
      ];
    };
  };
}
