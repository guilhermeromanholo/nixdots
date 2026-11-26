# nixdots

Configuração NixOS organizada pelo padrão dendritic, com flake-parts,
import-tree e nix-wrapper-modules.

## Organização

| Diretório | Responsabilidade |
| --- | --- |
| `modules/meta/` | Infraestrutura do flake, overlays, formatação e checks |
| `modules/system/` | Nix, usuários, rede, boot e contrato de persistência |
| `modules/theme/` | Esquema Base16, catálogo e integração com fontes, GTK e Qt |
| `modules/desktop/` | Contrato da sessão, compositores, painéis e greeter |
| `modules/apps/` | Aplicativos que podem ser usados independentemente da sessão |
| `modules/hardware/` | Políticas reutilizáveis de áudio, Bluetooth e energia |
| `modules/roles/` | Combinações de funcionalidades |
| `modules/hosts/` | Identidade, seleção de roles e hardware de cada máquina |
| `assets/` | Esquemas TOML e wallpapers |
| `tests/` | Regressões dos contratos e da composição NixOS |

Os arquivos Nix descobertos em `modules/` são módulos de flake-parts.
Arquivos e diretórios com prefixo `_` são auxiliares privados e não entram
na descoberta automática.

As contribuições para `flake.nixosModules` recebem uma `key` estável.
Preserve essa identidade ao editar módulos: ela impede que a composição de
roles importe a mesma contribuição duas vezes e duplique opções ou listas.

## Hosts e roles

Todos os hosts recebem o role `base`, diretamente ou por meio de outro role.
Ele disponibiliza os contratos de usuário, tema, persistência e sessão,
inclusive para máquinas que não usam ambiente gráfico ou Impermanence.

- `workstation`: base, rede, áudio, tema, aplicativos e convenções de atalhos.
- `laptop`: workstation, gerenciamento de energia e Bluetooth.
- `mango-noctalia`: compositor Mango, interface Noctalia e seleção de Kitty como terminal.
- `sway-waybar`: Sway, Waybar, Kitty, Fuzzel, Swaylock e captura de região para o clipboard.

Os hosts existentes continuam selecionando `mango-noctalia`. Para experimentar
a outra sessão, substitua esse role por `sway-waybar` na composição do host.
Selecione apenas um compositor por configuração.

Cada host mantém `hardware.nix` para dispositivos, discos e módulos de kernel.
O arquivo `default.nix` declara nome, `stateVersion`, preferências locais e roles.
O armazenamento de `taz` e `sunset` continua como estava: raiz em tmpfs, sem
ativação automática de Impermanence ou criação de novas partições.

## Temas

O catálogo lê apenas arquivos TOML regulares em `assets/schemes/`. Cada tema
precisa das cores `base00` a `base0F`, em hexadecimal `#RRGGBB`, e dos pacotes
de GTK, ícones e cursor. O wallpaper padrão fica em
`assets/wallpapers/<nome>/default.jpg`.

`flake.defaultTheme` define o padrão compartilhado. Um ajuste pontual no host
preserva os demais valores:

```nix
settings.theme.fonts.size = 20;
settings.theme.colors.base00 = "#202020";
```

Para selecionar outro tema e personalizá-lo, com `self` e `lib` disponíveis
no módulo de flake-parts:

```nix
settings.theme = lib.recursiveUpdate self.themes.nord {
  fonts.size = 20;
};
```

O overlay NixOS recebe o tema efetivo completo. Ajustes locais chegam aos
wrappers sem depender de um overlay cadastrado para aquele nome.

Os consumidores mantêm suas adaptações em `_palette.nix`, recebendo
`{ theme }`. O resultado tem o formato esperado pelo aplicativo: atributos
para Kitty, Helix, Starship e Noctalia; texto para Sway e Waybar.

Helix gera uma paleta própria, herdando os realces de `base16_default_dark`.
Starship mantém o layout do preset rainbow e aplica a paleta selecionada.
Os nomes de pacote nos TOMLs são caminhos de atributos de nixpkgs, como
`nerd-fonts.fira-code`.

## Ações, atalhos e modos

Os aplicativos registram ações perto de sua implementação. Por exemplo,
o módulo do Kitty declara:

```nix
session.actions."kitty.open".argv = [ (lib.getExe pkgs.my.kitty) ];
```

O role escolhe a implementação da ação genérica:

```nix
session.actions."terminal.open" = config.session.actions."kitty.open";
```

Um binding executa uma ação ou troca de modo:

```nix
session.bindings.default = [
  { modifiers = [ "SUPER" ]; key = "a"; switchTo = "apps"; }
];

session.bindings.apps = [
  { key = "t"; action = "kitty.open"; }
  { key = "Escape"; switchTo = "default"; }
];
```

Essas contribuições podem ficar em arquivos diferentes. Aplicativos podem
contribuir com seus próprios bindings; a sessão mantém as convenções gerais.

- Modificadores: `SUPER`, `SHIFT`, `CTRL` e `ALT`; lista vazia significa nenhum.
- `key` recebe um keysym XKB, como `Return`, `Escape` ou `comma`.
- `release = true` executa o binding ao soltar a tecla.
- Cada binding define exatamente um dos campos `action` e `switchTo`.
- `session.common` disponibiliza atalhos em todos os modos.
- `default` sempre existe; `common` é reservado ao adaptador.
- Retornos entre modos são explícitos; não existe uma pilha automática de modos.

Os adaptadores geram `key_mode`/keymode no Mango e blocos `mode` no Sway.
O wrapper de Mango adapta a sintaxe à versão instalada.
No Sway, os atalhos comuns são incluídos em cada modo.

A configuração rejeita ações inexistentes ou sem implementação para o compositor,
transições para modos inexistentes e colisões de combinações dentro do mesmo modo,
inclusive entre atalhos comuns e locais.

Ações de processos usam `argv`, com escape feito pelo adaptador. Ações nativas
podem oferecer implementações específicas:

```nix
session.actions."window.close" = {
  mango = "killclient";
  sway = "kill";
};
```

A implementação nativa tem precedência sobre `argv` para aquele compositor.
Comandos de início da sessão usam `session.autostart`, uma lista de listas de argumentos.

Os atalhos anteriores foram mantidos. `Super+Shift+R` entra no novo modo
`resize`, com `h/j/k/l`; `Escape` ou `Return` retorna a `default`.
`Super+R` recarrega a configuração em todos os modos.

## Persistência

Qualquer funcionalidade pode registrar seus caminhos:

```nix
persist.root.directories = [ "/var/lib/example" ];
persist.user.directories = [ ".local/state/example" ];
```

Caminhos de sistema são absolutos; caminhos do usuário são relativos ao home.
Os registros são disponibilizados por `base` e não criam mounts por si só.

Para consumi-los, importe `self.nixosModules.impermanence` no host e configure
um filesystem persistente em `persist.storagePath`, cujo padrão é `/persist`.
Esse filesystem precisa de `neededForBoot = true`. A configuração dos discos
continua pertencendo ao host.

O consumidor também preserva `/etc/machine-id` e `/var/lib/nixos`.
SSH, NetworkManager, Tailscale e Bluetooth registram seu estado nos próprios módulos.
Nenhum host existente passou a usar Impermanence automaticamente.

## Wrappers e arquivos nativos

O módulo de instalação de um programa fica junto de seu wrapper.
Os contratos compartilhados ficam em `self.lib.wrapperModules`, como módulos
importáveis com a mesma convenção usada pelo wlib:

```nix
imports = [
  wlib.wrapperModules.kitty
  self.lib.wrapperModules.theme
];
```

Compositores também importam `self.lib.wrapperModules.session`.
Esse registro fica separado de `self.wrapperModules`, que a dependência gera
automaticamente a partir dos wrappers dos aplicativos.

Configuração estruturada permanece em Nix quando recebe valores derivados;
código Zsh e arquivos próprios de Sway e Waybar ficam em `_config/`.

Os pacotes independentes ficam em `packages.<system>`, por exemplo:

```sh
nix run path:.#helix
```

Os wrappers de compositores são configuráveis: os pacotes independentes não
selecionam um role ou herdam implicitamente a sessão de um host. No NixOS,
o overlay recebe a sessão composta e o shell escolhido.

A função de overlay aceita:

```nix
self.lib.mkOverlay {
  theme = config.settings.theme;
  session = config.session;
  shellPackage = config.settings.user.shell;
}
```

Darwin exporta apenas os wrappers de programas compatíveis.
Noctalia converte seus settings para TOML durante o build, sem import from derivation.

## Validação

Durante a revisão, `path:.` inclui os arquivos novos ainda não adicionados ao Git.

```sh
nix flake check path:. --no-build --all-systems
nix run path:.#formatter.x86_64-linux -- --fail-on-change
nix build path:.#nixosConfigurations.tesla.config.system.build.toplevel --no-link
```

Os checks `session`, `theme` e `system` avaliam testes de modos, conflitos,
aliases, propagação de temas e persistência opcional. O check `treefmt`
verifica formatação com nixfmt e código morto com deadnix.

Avaliar uma derivação não executa nem instala o sistema. A autenticação
existente foi preservada nesta refatoração, incluindo a senha inicial
`password` e SSH com autenticação por senha.
