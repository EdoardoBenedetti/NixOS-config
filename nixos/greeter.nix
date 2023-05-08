{ config, pkgs, lib, ... }:

{
  services.greetd = {
    enable = true;
    package = pkgs.greetd.greetd;
    settings = {
      default_session = {
        command = let 
          tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
          sessions = "--sessions /etc/greetd/sessions";
          message = "-g 'Welcome, Traveler'";
        in
          builtins.concatStringsSep " " [
            tuigreet
            sessions
            message
            "--time --user-menu --remember-session --asterisks"
          ];
        user = "greeter";
      };
    };
  };

  environment.etc = {
    "greetd/sessions/Hyprland.desktop".text = ''
      [Desktop Entry]
      Version=1.0
      Type=XSession
      Exec=Hyprland
      Name=Hyprland
      DesktopNames=Hyprland
    '';
    "greetd/sessions/Sway.desktop".text = ''
      [Desktop Entry]
      Version=1.0
      Type=XSession
      Exec=Sway
      Name=Sway
      DesktopNames=Sway
    '';
    "greetd/sessions/Gnome.desktop".text = ''
      [Desktop Entry]
      Version=1.0
      Type=XSession
      Exec=/etc/greetd/sessions/GnomeWrapper.sh
      Name=Wayland GNOME
      DesktopNames=GNOME
    '';
    "greetd/sessions/GnomeWrapper.sh" = {
      text = ''
        #!/bin/sh
        dbus-run-session -- gnome-shell --display-server --wayland
      '';
      mode = "0755";
    };
  };
}
