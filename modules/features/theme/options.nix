{ self, lib, ... }:
let
  themeType = import ./_type.nix { inherit lib; };
in
{
  options.flake = lib.mkOption {
    type = lib.types.submoduleWith {
      modules = [
        {
          options.themes = lib.mkOption {
            type = lib.types.attrsOf themeType;
            default = { };
            description = "Catálogo tipado de temas compartilhados.";
          };
        }
      ];
    };
  };
  config.flake.modules.generic.wrapper-theme = { lib, ... }: {
    key = "nixdots:wrapper-theme";
    options.theme = lib.mkOption {
      type = themeType;
      default = self.themes.gruvbox;
      description = "Tema deste pacote; pode ser substituído ao chamar .wrap.";
    };
  };
  config.flake.modules.nixos.theme-options = { lib, ... }: {
    key = "nixdots:theme-options";
    options.nixdots.theme = lib.mkOption {
      type = themeType;
      default = self.themes.gruvbox;
      description = "Tema fixo selecionado pelo host.";
    };
  };
}
