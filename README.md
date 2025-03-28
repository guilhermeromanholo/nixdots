<div align="center">

<h1>NixOS Dotfiles</h1>
<p>Personal NixOS and NixOS-WSL configuration with home-manager, flake-parts and stylix.</p>
    
</div>


### :toolbox: Installation:

```sh
1) sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko path/to/disko.nix
2) sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hosts/${hostname}/hardware-configuration.nix
3) "Add hardware-configuration.nix in host imports"
4) sudo nixos-install --root /mnt --flake .#hostname
```

### :pencil: TODO:

* [ ] Adicionar firefox
* [X] Arrumar nome do cursor
* [X] Colocar parts em modules
* [ ] Arrumar tema do hyprpanel
* [X] Realocar os modulos de external
* [ ] Se possível pensar em uma logica para o appearence do home
* [ ] Deixar temas na raiz e separar appearence em gnome, stylix, hyprpanel, etc ...

### :gear: Nixvim:

This repo have a nixvim module that can be accessed by the following command:
```sh
nix run "github:guilherme-romanholo/nixdots"#nixvim
```

### ❓ Notes:

- Disko mode mount not erase the disk
- Use `nix repl` and `:lf .` to access flake variables
