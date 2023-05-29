{
  description = "Personal NixOS/Home-Manager Configuration";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11"; # Stable until June 2023
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05"; # Stable until Dec 2023
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # Unstable version
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:

  let
    system = "x86_64-linux";
    overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          postPatch = ''
            sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
          '';
        });
      })
    ];
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      inherit overlays;
    };
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
      inherit overlays;
    };
  in 

  {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit pkgs; inherit unstable; };
      modules = [
        ./nixos/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit unstable;
            };
            users.edoardo = import ./nixos/home.nix;
          };
        }
      ];
    };

  };

}
