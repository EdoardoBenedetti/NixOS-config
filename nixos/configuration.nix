{ config, pkgs, unstable, ... }:

{
  imports = [
    ./hardware-configuration.nix 
    ./system.nix
    ./greeter.nix
  ];

  # ---------------------------------------------------------------------------------------------------
  # USERS
  users.users.edoardo = {
    isNormalUser = true;
    home= "/home/edoardo";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
  };
  
  # ---------------------------------------------------------------------------------------------------
  # DESKTOP
  services = {
    xserver.desktopManager.gnome.enable = false; # Temporarily disabled
    gnome = {
      core-utilities.enable = false;
      gnome-keyring.enable = true;
      tracker.enable = false;
      tracker-miners.enable = false;
    };
  };
  programs = {
    seahorse.enable = true;
    sway.enable = true;
    hyprland.enable = true;
  };
  security = {
    pam.services.greetd.enableGnomeKeyring = true;
    sudo.execWheelOnly = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  fonts = {
    fonts = [ pkgs.nerdfonts ];
    fontDir.enable = true;
  };
  
  # ---------------------------------------------------------------------------------------------------
  # PACKAGES
  environment.systemPackages = with pkgs; [
    alacritty
    android-tools
    appimage-run
    bibata-cursors
    cage # Single window wayland compositor
    clinfo
    cryptsetup
    git
    glxinfo
    gnome.adwaita-icon-theme
    gparted
    greetd.tuigreet
    helvum
    htop
    libappindicator
    lsof
    neovim
    ntfs3g
    ocl-icd
    openvpn
    pamixer
    pavucontrol
    pciutils
    playerctl
    polkit_gnome
    usbutils
    wget
    wl-clipboard
    wlr-randr
    xdg-utils
    xorg.xhost
    zsh

    # Dev
    binutils
    cairo
    cargo
    docker-compose
    gcc
    gnumake
    pkg-config
    python3
    python3Packages.pip
    rustc
  ] ++ (with unstable; [
    hello # Just a placeholder, nothing fancy
  ]);

  # Nix Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # ---------------------------------------------------------------------------------------------------
  # OTHERS
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
