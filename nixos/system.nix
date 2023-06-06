{ config, pkgs, ... }:

{
  # ---------------------------------------------------------------------------------------------------
  # BOOTLOADER
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        extraEntries = {
          # Must copy /EFI/Microsoft from Microsoft partition to /boot/EFI/Microsoft
          # It's probably detected automatically anyway, this is just here as a backup
          "Windows10.conf" = ''
            title Windows
            efi /boot/EFI/Microsoft/Boot/Bootmgfw.efi
          '';
        };
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages;
    kernelModules = [ "k10temp" "amdgpu"]; 
    extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ];
    kernelParams = [ 
      "quiet"
      "amdgpu.dc=1"
      "amdgpu.dcfeaturemask=0xffffffff"
      "video=1920x1080"
    ];
  };

  # ---------------------------------------------------------------------------------------------------
  # AUDIO
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true; # Reduces latency for high-priority tasks
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  # ---------------------------------------------------------------------------------------------------
  # GRAPHICS
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = [
      pkgs.rocm-opencl-runtime
      pkgs.rocm-opencl-icd
    ];
  };   

  # ---------------------------------------------------------------------------------------------------
  # NETWORKING AND CONNECTIONS
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    enableIPv6 = false;
    usePredictableInterfaceNames = false;
    firewall = {
      enable = true;
      #allowedTCPPorts = [ 3000 ];
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };
  };
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no"; # NixOS 23 and later
      ports = [ 2541 ]; # Damn, not I'mma get doxxed /s
      allowSFTP = true;
    };
  };
  hardware.bluetooth.enable = true;
  programs.openvpn3.enable = true;

  # ---------------------------------------------------------------------------------------------------
  # OTHERS
  system.stateVersion = "23.05";

  services = {
    printing.enable = true;
    flatpak.enable = true;
    avahi.enable = true;
    blueman.enable = true;
  };
  programs = {
    zsh = {
      enable = true;
      ohMyZsh.enable = true;
    };
    dconf.enable = true;
  };

  # Time and Language
  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
