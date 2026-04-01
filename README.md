### Important

- Usar completamente o padrão dendritic, seguindo aspectos e linusammon para inputs;
- Não se preocupar com home-manager, não faz sentido usar Gnome sem HM por exemplo;
- Nix-colors: colocar no mesmo aspect para todos que precisam de temas, e depois fazer specialisations no base em tools/;
- Utilizar factory para usuários, temas, discos, ...;

### Install

- ```nix run github:nix-community/nixos-anywhere -- --flake <path to configuration>#<configuration name> --target-host root@<ip address>```

### Layout

```
lib/ (funções para o flake: import-tree, import-hosts, import-users)
packages/ (pacotes customizados, como dotfiles para o tema)
templates/ (templates que eu uso para linguagens)
modules/
| - programs/ (programas normais: gnome, kitty, ...)
| - services/ (servicos do sistema: ssh, printing, ...)
| - tools/ (coisas externas: home-manager, nixvim, impermanence, ...)
|   | disko/ (colocar partes dos layouts?)
| - hosts/ (minhas máquinas)
| - users/ (usuarios das máquinas)
| - bundles/ (combinação de modulos: cli, games, x-de)
| - system/ (basear na do linusammon)
|   | - settings/ (configurações de boot, nix, locale, ...)
|   | - types/ (tipos de sistema: base, desktop, laptop, cli, ...)
| - factory/ (*apenas se for muito necessário)
```

### Issues

- Layout do teclado: utilizar sempre dois padrões "br, us";
- Monitores: deixar a configuração padrão (ou nos hosts com mkDefault);
- Locale e timezone: mesma ideia dos monitores;
- Troca de cores: specialisations e um modulo separado;

### Styling

- [ ] gtk
- [ ] cli?
- [ ] sway
- [ ] niri
- [ ] wofi
- [ ] tmux
- [ ] icons
- [ ] kitty
- [ ] cursor
- [ ] swaync
- [ ] waybar
- [ ] cosmic?
- [ ] firefox
- [ ] swaylock
- [ ] wallpaper
