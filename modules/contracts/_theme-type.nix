{ lib }:
let
  inherit (lib) mkOption types;
  color = types.strMatching "#[0-9a-fA-F]{6}";
  namedPackageModule = {
    options = {
      name = mkOption {
        type = types.str;
        description = "Nome reconhecido pelo toolkit.";
      };
      package = mkOption {
        type = types.str;
        description = "Atributo do pacote no nixpkgs.";
      };
    };
  };
  namedPackage = types.submodule namedPackageModule;
in
types.submodule (
  { config, ... }: {
    options = {
      name = mkOption {
        type = types.enum [
          "gruvbox"
          "nord"
        ];
        description = "Identificador do tema.";
      };
      polarity = mkOption {
        type = types.enum [
          "dark"
          "light"
        ];
        default = "dark";
        description = "Polaridade do tema.";
      };
      colors = mkOption {
        type = types.submodule {
          options =
            lib.genAttrs
              (map (n: "base0${n}") [
                "0"
                "1"
                "2"
                "3"
                "4"
                "5"
                "6"
                "7"
                "8"
                "9"
                "A"
                "B"
                "C"
                "D"
                "E"
                "F"
              ])
              (
                _:
                mkOption {
                  type = color;
                  description = "Cor Base16 em hexadecimal com #.";
                }
              );
        };
        description = "Paleta Base16 compartilhada.";
      };
      semantic = mkOption {
        type = types.submodule {
          options =
            lib.genAttrs
              [
                "background"
                "foreground"
                "surface"
                "muted"
                "accent"
                "error"
                "success"
                "warning"
              ]
              (
                _:
                mkOption {
                  type = color;
                  description = "Papel semântico da cor.";
                }
              );
        };
        default = {
          background = config.colors.base00;
          foreground = config.colors.base05;
          surface = config.colors.base01;
          muted = config.colors.base03;
          accent = config.colors.base0D;
          error = config.colors.base08;
          success = config.colors.base0B;
          warning = config.colors.base0A;
        };
        description = "Papéis visuais derivados da paleta.";
      };
      fonts = mkOption {
        type = types.submodule {
          options = {
            monospace = mkOption {
              type = types.str;
              default = "FiraCode Nerd Font Mono";
              description = "Fonte monoespaçada.";
            };
            sans = mkOption {
              type = types.str;
              default = "Open Sans";
              description = "Fonte da interface.";
            };
            serif = mkOption {
              type = types.str;
              default = "Roboto Serif";
              description = "Fonte serifada.";
            };
            size = mkOption {
              type = types.ints.positive;
              default = 11;
              description = "Tamanho base em pontos.";
            };
          };
        };
        default = { };
        description = "Tipografia compartilhada.";
      };
      cursor = mkOption {
        type = types.submodule {
          imports = [ namedPackageModule ];
          options.size = mkOption {
            type = types.ints.positive;
            default = 24;
            description = "Tamanho do cursor.";
          };
        };
        description = "Tema e tamanho do cursor.";
      };
      icons = mkOption {
        type = namedPackage;
        description = "Tema de ícones.";
      };
      gtk = mkOption {
        type = namedPackage;
        description = "Tema GTK.";
      };
      wallpaper = mkOption {
        type = types.path;
        description = "Wallpaper estático no store.";
      };
      opacity = mkOption {
        type = types.numbers.between 0.0 1.0;
        default = 0.85;
        description = "Opacidade dos terminais.";
      };
    };
  }
)
