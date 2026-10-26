# nixdots

Configuração NixOS dendrítica com flake-parts, Fish + Starship, Helix e
MangoWM + Noctalia v5. Os aplicativos configurados são pacotes produzidos por
nix-wrapper-modules. A configuração anterior permanece em `old/`.

| Host | Ambiente | Usuário | Tema |
| --- | --- | --- | --- |
| `sunset` | Mango + Noctalia | `guilherme` | Gruvbox |
| `taz` | Mango + Noctalia | `guilherme` | Nord |
| `vortex` | WSL | `guilherme` | Nord |
| `tesla` | ThinkPad T480, módulo pendente de hardware | `guilherme` | Gruvbox |

## Organização

- `modules/features/`: configuração de cada funcionalidade, com wrappers e integração NixOS no mesmo módulo.
- `modules/features/desktop/`: compositor, shell gráfica e sessão de login.
- `modules/features/theme/`: opções tipadas, paletas e integração com fontes, GTK, Qt e cursor.
- `modules/features/system/`: configuração básica do sistema, usuário e persistência.
- `modules/hosts/<nome>/`: seleção de funcionalidades e diferenças da máquina em `default.nix`, junto dos arquivos reais de hardware e disko.
- `modules/meta/`: composição de hosts e perfis, overlay/exportação de pacotes, checks e ambientes de desenvolvimento.
- `tests/`: verificação de inicialização dos servidores LSP.

```text
modules/
├── features/
│   ├── fish.nix
│   ├── starship.nix
│   ├── helix.nix
│   ├── kitty.nix
│   ├── desktop/
│   ├── theme/
│   │   ├── options.nix
│   │   ├── _type.nix
│   │   ├── gruvbox.nix
│   │   ├── nord.nix
│   │   └── default.nix
│   └── system/
│       ├── default.nix
│       ├── user.nix
│       └── persistence.nix
├── hosts/
│   ├── sunset/
│   │   ├── default.nix
│   │   ├── _hardware.nix
│   │   └── _disko.nix
│   ├── taz/
│   ├── vortex/
│   └── tesla/
└── meta/
    ├── hosts.nix
    ├── profiles.nix
    ├── packages.nix
    ├── checks.nix
    └── development.nix
```

O [import-tree](https://github.com/denful/import-tree) descobre os arquivos
`.nix` dentro de `modules/`. Arquivos ou diretórios com prefixo `_` ficam fora
da descoberta: `_type.nix` e `_noctalia-palette.nix` são auxiliares, enquanto
`_hardware.nix` e `_disko.nix` são módulos NixOS importados explicitamente pelo
host. Os demais arquivos devem ser módulos de flake-parts, inclusive `default.nix`.
Ao adicionar uma funcionalidade, basta criar seu módulo; não há lista central
de arquivos a atualizar.

A composição usa flake-parts e `flake.modules.nixos`. Descobrir um arquivo
registra suas definições; os imports dos perfis e hosts continuam explícitos
e determinam quais funcionalidades são ativadas. As saídas dos hosts prontos
para rebuild ficam em `modules/meta/hosts.nix`; descobrir o módulo do Tesla
não o publica como um sistema pronto.

As opções compartilhadas ficam junto da funcionalidade responsável, sem uma
camada separada de contratos. `system/user.nix` declara `nixdots.user.name`;
o home usa a opção nativa `users.users.<nome>.home`. `theme/options.nix` declara
o catálogo de temas, a opção NixOS `nixdots.theme` e a opção `theme` dos wrappers,
usando o mesmo tipo. O host seleciona seu tema, o overlay o passa aos wrappers,
e os aplicativos convertem a paleta para seus formatos.

A persistência mantém somente `nixdots.persistence.enable` e `root` como opções
próprias. Hosts e funcionalidades contribuem diretamente para
`environment.persistence`, do impermanence. Contribuições de aplicativos são
condicionadas a `enable`, de modo que WSL e hosts sem persistência não ganhem
montagens. Os caminhos físicos existentes continuam os mesmos.

## Pacotes e wrappers

O overlay fornece `pkgs.nixdots.<programa>`, mantendo os pacotes originais do
nixpkgs disponíveis. Os wrappers são definidos uma vez e compartilhados pelo
overlay e pelas saídas de pacotes da flake.

```console
nix build .#helix
nix run .#helix -- --health nix
nix run .#fish
nix build .#kitty .#mango .#noctalia
```

Os pacotes independentes usam Gruvbox por padrão. Os hosts passam seu tema
explicitamente. É possível reutilizar e personalizar um wrapper em outra flake:

```nix
inputs.nixdots.wrappers.helix.wrap {
  inherit pkgs;
  theme = inputs.nixdots.themes.nord;
  settings.editor.line-number = "relative";
}
```

Também são exportados `overlays.default` (Gruvbox) e `overlays.nord`. Cada
integração NixOS usa `lib.mkOverlay config.nixdots.theme`, portanto Taz e Vortex
não herdam por acidente o tema dos pacotes independentes.

Fish é configurado como shell de login; Starship, zoxide e direnv são
inicializados apenas em sessões interativas. O suporte a nix-direnv é fornecido
no NixOS. Helix usa `nixd` para Nix e `ty server` para Python, com os executáveis
declarados no pacote. Nenhum formatador adicional foi escolhido.

Git continua incluindo `~/.gitconfig` para preservar identidade, assinatura e
includes existentes. O restante da configuração pode ser estendido pelo
wrapper. Firefox mantém perfis graváveis e Vesktop usa o Vencord do nixpkgs.

## Tema e estado

O tema é fixo por host e muda por rebuild. As paletas antigas de Gruvbox/Nord e
seus wallpapers foram reaproveitados. Fish, Starship, Helix, Kitty, Mango e
Noctalia recebem o mesmo tema tipado. GTK usa o tema correspondente; a
integração Qt usa inicialmente Adwaita escuro e as preferências de interface
compartilhadas via GNOME. A paleta exata de GTK não é reproduzida em todos os
widgets Qt.

O wrapper do Noctalia v5 usa `NOCTALIA_CONFIG_HOME` para ler configuração e
paleta do store. O processo é iniciado pelo autostart do Mango. Swaybg é o único
responsável pelo wallpaper; o serviço de wallpaper do Noctalia fica desativado.

Como o Noctalia lê os overrides da interface depois da configuração, o wrapper
usa uma raiz própria de estado:

```text
~/.local/state/nixdots/noctalia/
  settings.toml -> /nix/store/.../config/noctalia/config.toml
  ... outros arquivos de estado graváveis ...
```

O link é administrado somente nesse namespace; um arquivo ou link desconhecido
causa erro em vez de ser sobrescrito. `XDG_STATE_HOME` é respeitado. Preferências
salvas em `~/.local/state/noctalia` não são removidas nem importadas silenciosamente.
Alterações persistentes pela interface do Noctalia ficam bloqueadas; personalize
`wrappers.noctalia.settings` e faça rebuild. Cache, credenciais e outros dados
mutáveis continuam fora do store. Nenhuma variável XDG global é redirecionada
pela sessão para tornar os outros aplicativos imutáveis.

## Verificação

```console
nix flake check --no-build
nix flake check -L
nix build .#nixosConfigurations.sunset.config.system.build.toplevel
nix build .#nixosConfigurations.taz.config.system.build.toplevel
nix build .#nixosConfigurations.vortex.config.system.build.toplevel
```

Os checks incluem temas e usuários dos quatro hosts, persistência desativada
em Taz/Vortex, shell interativo e de login,
configuração do Helix, handshake LSP de nixd/ty e validação nativa do TOML do
Noctalia. O wrapper pronto de Mango valida sua configuração durante o build.
Uma avaliação não equivale a um build; um build não equivale a um teste da
sessão gráfica.

Os ambientes de desenvolvimento ficam disponíveis com `nix develop`,
`nix develop .#java` e `nix develop .#poetry`. O shell Poetry fornece as
bibliotecas nativas necessárias; use os comandos normais de ativação do Poetry,
sem redefinir o comando de sistema `env`.

## Migração e ativação

1. Mantenha a geração atual e uma cópia dos dados persistentes. Os arquivos
   gerados de hardware e os layouts disko de Sunset/Taz foram copiados sem
   alterações; confirme que ainda correspondem aos discos presentes.
2. Confira os dados e a configuração efetivamente gerados, e execute os checks
   e o build do host correspondente. Ao usar a flake por Git, inclua os novos
   arquivos no índice; alternativamente use `path:/caminho/para/nixdots` durante
   a revisão, para incluir arquivos ainda não rastreados.
3. Faça a ativação somente na máquina correspondente, após revisar o resultado:

   ```console
   sudo nixos-rebuild test --flake .#sunset
   ```

4. Teste login Fish, Mango/Noctalia, terminal, launcher, áudio, portais,
   screenshots, bloqueio, suspensão e persistência. Reinicie a sessão gráfica
   para carregar os novos wrappers após um rebuild.
5. Depois da validação, use `nixos-rebuild switch --flake .#sunset`, ajustando o
   host. Para retornar, use `sudo nixos-rebuild switch --rollback` ou selecione
   uma geração anterior no boot.

Não é necessário executar disko para essa refatoração. Os builds e checks não
reparticionam discos, não ativam sistemas e não migram dados de contas.

Os usuários existentes mantêm suas credenciais; nenhum `initialPassword` é
definido. Para uma instalação nova ou para o novo usuário do Vortex, provisione
senha/chave antes de depender dessa conta para login.

### Vortex

O usuário padrão do WSL passa de `nixos` para `guilherme`. A configuração não
renomeia a conta antiga nem move seu home. Antes de ativar:

- Prepare o acesso de `guilherme` e revise UIDs, grupos e propriedade dos dados.
- Migre explicitamente apenas os dados desejados de `/home/nixos`; preserve a
  origem até confirmar o funcionamento.
- Encerre e reabra a distribuição pelo Windows para aplicar o usuário padrão do
  WSL, se necessário. Mantenha acesso como root durante a transição.

### Sunset

A disposição física da persistência foi mantida:
`/persist/system` para o sistema e `/persist/home/guilherme` para os dados
pessoais. Além dos diretórios antigos, são preservados estado do Fish, Noctalia,
Vesktop e keyring. `system.stateVersion` continua em `24.11`, assim como Taz e
Vortex. A refatoração não faz limpeza dos diretórios antigos do home.

### Tesla

`modules.nixos.tesla` está disponível, com perfil de laptop, usuário e Gruvbox.
Ele contém uma assertion que impede ativação sem hardware/discos reais e sem
confirmar o `system.stateVersion` instalado. Por isso não há uma saída
`nixosConfigurations.tesla` pronta para rebuild.

Quando os arquivos reais forem fornecidos, importe-os no módulo, defina o
`stateVersion` correto, remova a assertion de pendência e acrescente `tesla` à
lista de configurações em `modules/meta/hosts.nix`. Valide também tampa,
bateria, suspensão, teclado, TrackPoint/touchpad e monitores externos.

## Alterações em relação a old/

- Home Manager, Stylix, Zsh/Powerlevel10k e os editores antigos saem da nova
  composição. Não há adaptador de módulos Home Manager nem gerenciador genérico
  de symlinks para dotfiles.
- Sway, Hyprland, GNOME, Wofi, Waybar e Hyprpanel são substituídos pelo novo
  desktop nos perfis gráficos.
- Taz mantém impressão/scanner, pcscd/GnuPG, Docker, libvirt/QEMU, ferramentas
  virtuais e Tailscale. Sunset mantém impressão/scanner e impermanence. SSH e
  Tailscale continuam nos hosts existentes.
- Tesla tem hardware pendente. Nenhum layout foi deduzido apenas pelo nome T480.
- As configurações atuais detalhadas de Fish, Starship e Helix ainda podem ser
  incorporadas; os wrappers começam com uma base pequena e personalizável.

As decisões e as referências de arquitetura estão em [AGENTS.md](AGENTS.md).
