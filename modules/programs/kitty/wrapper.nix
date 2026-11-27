{
  lib,
  self,
  ...
}: {
  flake.wrappers.kitty = self.lib.mkWrapper "kitty" (
    {pkgs, ...}: {
      settings = {
        shell = lib.getExe pkgs.fish;
        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";
        enable_audio_bell = "no";
        confirm_os_window_close = 0;
      };
    }
  );
}
