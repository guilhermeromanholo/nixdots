# NixOS Configuration


### TODO:

- Verificar se home.nix também é aplicado ao usuário (hm switch);


### 💻 Hosts


### :toolbox: Installation

```sh
1) sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko path/to/disko.nix
2) sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hosts/${hostname}/hardware-configuration.nix
3) "Add hardware-configuration.nix in host imports"
4) sudo nixos-install --root /mnt --flake .#hostname
```
