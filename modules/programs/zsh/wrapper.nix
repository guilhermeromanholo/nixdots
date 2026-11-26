{ self, lib, ... }:
{
  flake.wrappers.zsh = { wlib, pkgs, ... }: {
    imports = [
      wlib.wrapperModules.zsh
      self.lib.mkThemeOption
    ];
    runtimePkgs = with pkgs; [
      bat
      eza
      atuin
      zoxide
      my.starship
    ];
    zshAliases = {
      cd = "z";
      cat = lib.getExe pkgs.bat;
      ls = "${lib.getExe pkgs.eza} --icons --group-directories-first";
      ll = "${lib.getExe pkgs.eza} -l --icons --group-directories-first";
      la = "${lib.getExe pkgs.eza} -la --icons --group-directories-first";
    };
    zshrc.path = pkgs.replaceVars ./_config/zshrc.zsh {
      completions = "${pkgs.zsh-completions}/share/zsh/site-functions";
      atuin = lib.getExe pkgs.atuin;
      zoxide = lib.getExe pkgs.zoxide;
      starship = lib.getExe pkgs.my.starship;
      autosuggestions = "${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh";
      highlighting = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
    };
  };
}
