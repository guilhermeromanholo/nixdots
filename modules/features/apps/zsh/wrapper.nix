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

    zshrc.content = ''
      fpath=(${pkgs.zsh-completions}/share/zsh/site-functions $fpath)
      autoload -Uz compinit && compinit

      eval "$(${lib.getExe pkgs.atuin} init zsh)"
      eval "$(${lib.getExe pkgs.zoxide} init zsh)"
      eval "$(${lib.getExe pkgs.my.starship} init zsh)"

      source ${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
    '';
  };
}
