{ config, pkgs, unstable, ... }:

let
  user = "edoardo";
  homedir = "/home/${user}";
in

{
  home.username = "${user}";
  home.homeDirectory = "${homedir}";
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [ 
    # Free
    bitwarden
    blender
    chromium
    epiphany
    filezilla
    firefox
    freecad
    gimp
    gitg
    gnome.dconf-editor
    gnome.eog
    gnome.file-roller
    gnome.gnome-calculator
    gnome.gnome-disk-utility
    gnome.gnome-tweaks
    gnome.gnome-weather
    gnome.nautilus
    gnome-solanum
    grim
    gtg
    gtk-engine-murrine
    jq
    libnotify
    libreoffice
    neofetch
    obs-studio
    prismlauncher
    qbittorrent
    rofi-wayland
    selectdefaultapplication
    slurp
    sptlrx
    swappy
    swaybg
    swayosd
    swaynotificationcenter
    thunderbird
    vlc
    vscodium
    waybar
    xfce.thunar

    # Dev
    nodejs
    yarn

    # Non-Free
    authy
    dropbox
    spotify
  ] ++ (with unstable; [
    lapce
    pw-viz
  ]);

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  gtk = {
    enable = true;
    font = {
      name = "Arimo Nerd Font";
      size = 12;
    };
    theme = {
      name = "Gruvbox-Dark-BL";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme.name = "Bibata-Modern-Ice";
  };

  home.file = {
    ".config/hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "${homedir}/NixOS/dots/hypr";
    };
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${homedir}/NixOS/dots/nvim";
    };
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "${homedir}/NixOS/dots/zshrc";
    };
  };
}


  
