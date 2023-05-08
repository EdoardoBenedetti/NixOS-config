# NixOS Configuration

This is my own personal configuration for NixOS. If somehow you ended up here,
feel free to clone it or take inspiration from it! <sub>(I do not recommend cloning 
blindly since some specific parts of the configuration are configured for my 
specific hardware.)<sub>

I'm not entirely sure I know what I'm doing, but as long as it works I'm good
with it. You should not copy any part of it if you have no clue about it.

### Index

- [Cheatsheet](#cheatsheet)
- [Issues](#issues)

---

## Cheatsheet

Here is a little cheat sheet that could be useful in case I forget how any of
it works. :)

- **Update the system**\
  To update the system, run:\
  `$ nix flake update`\
  <sup>This will update the flake.lock file, updating all the dependencies</sup>\
  And:\
  `$ sudo nixos-rebuild switch --flake /path/to/flake.nix`
  
  <br>

- **Clean the garbage**\
  You should not run it unless you are sure you current system is 100% safe.
  `$ sudo nix-collect-garbage -d`

---

## Issues

- I have no idea about what I'm doing, that's the main issue
- I'm not sure if I should patch waybar or not, since the Hyprland flake comes with a patch but I have no idea how to apply it.
- Can't install unstable packages on my HomeManager, I'm not entirely sure why