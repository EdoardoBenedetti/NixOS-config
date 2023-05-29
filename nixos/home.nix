{ config, pkgs, unstable, ... }:

{
  home.username = "edoardo";
  home.homeDirectory = "/home/edoardo";
  home.stateVersion = "18.09";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [ 
    # Free
    bitwarden
    blender
    chromium
    epiphany
    ferdium
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
}


  
