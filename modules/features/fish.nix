{ self, ... }: {
  flake.wrappers.fish =
    {
      config,
      wlib,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        wlib.wrapperModules.fish
        self.modules.generic.wrapper-theme
      ];
      runtimePkgs = with pkgs; [
        bat
        eza
        zoxide
        direnv
        nix-direnv
      ];
      env = {
        EDITOR = lib.getExe pkgs.nixdots.helix;
        VISUAL = lib.getExe pkgs.nixdots.helix;
        DIRENV_LOG_FORMAT = "";
      };
      shellAliases = {
        cat = "bat";
        ls = "eza --icons=auto";
        gs = "git status";
        dots = "z ~/.nixdots";
      };
      configFile.content = ''
        if status is-interactive
          set -g fish_greeting
          set -g fish_color_command ${lib.removePrefix "#" config.theme.semantic.accent}
          set -g fish_color_error ${lib.removePrefix "#" config.theme.semantic.error}
          set -g fish_color_param ${lib.removePrefix "#" config.theme.semantic.foreground}
          set -a fish_complete_path /run/current-system/sw/share/fish/vendor_completions.d
          ${lib.getExe pkgs.zoxide} init fish | source
          ${lib.getExe pkgs.direnv} hook fish | source
          if test "$TERM" != dumb
            ${lib.getExe pkgs.nixdots.starship} init fish | source
          end
        end
      '';
    };
  flake.modules.nixos.fish =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      programs.fish.enable = true;
      environment.shells = [ pkgs.nixdots.fish ];
      users.users.${config.nixdots.user.name} = {
        shell = pkgs.nixdots.fish;
        packages = [
          pkgs.nixdots.starship
          pkgs.bat
          pkgs.eza
          pkgs.zoxide
          pkgs.direnv
          pkgs.devenv
        ];
      };
      environment.etc."direnv/direnvrc".text = ''
        source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc
      '';
      environment.persistence = lib.mkIf config.nixdots.persistence.enable {
        ${config.nixdots.persistence.root}.users.${config.nixdots.user.name}.directories = [
          ".local/share/fish"
          ".config/fish"
        ];
      };
    };
}
