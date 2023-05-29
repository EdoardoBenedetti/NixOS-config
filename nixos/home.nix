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
    gruvbox-gtk-theme
    gtg
    gtk-engine-murrine
    jq
    libnotify
    libreoffice
    neofetch
    nerdfonts
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
    theme.name = "Gruvbox-Dark-BL";
    cursorTheme.name = "Bibata-Modern-Ice";
  };
}


  
