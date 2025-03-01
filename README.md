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

* [x] *Make flake module for packages*
* [ ] Add flake custom schemas to outputs
* [x] Add Nixvim in custom packages
* [x] Add all modules in the shared branch
* [ ] Add Shyfox theme in the Firefox module
* [x] Make optional imports with "?" operator
* [ ] Create Hyprpanel, Hyprlock, Swayidle and Nixcord modules
* [ ] Make template with my configuration
* [x] Move themes to style modules
* [x] Understand how flakeModules works
* [ ] Add Nix Helper

### :gear: Nixvim:

This repo have a nixvim module that can be accessed by the following command:
```sh
nix run "github:guilherme-romanholo/nixdots"#nixvim
```

### ❓ Notes:

- Disko mode mount not erase the disk
- Use `nix repl` and `:lf .` to access flake variables
