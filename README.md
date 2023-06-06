# NixOS Configuration

Personal configuration for NixOS. If somehow you ended up here,
feel free to clone it or take inspiration from it! 

As a side note I have little experience with NixOS, so some things might be wrong. Even if it works for me, might not work for you!

---

## Usage

Just clone it into your home directory in a folder called NixOS.\
Replace my username with yours where necessary.

To apply changes:\
`$ sudo nixos-rebuild switch --flake ~/NixOS/.#`

Update the packages with `$ nix flake update` and again apply the changes.\
Clean the garbage with `$ sudo nix-collect-garbage -d`, just make sure everything works correctly before running the command.