{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

    # NOTE : we pin ags since version 2.x.x is totally different and need to start config from scratch
    ags.url = "github:Aylur/ags/ref=v1.8.2";

    stylix.url = "github:danth/stylix";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swww.url = "github:LGFae/swww";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        inspiron = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.overlays = [ inputs.hyprpanel.overlay ];
              _module.args = {
                inherit inputs;
              };
            }

            ./hosts/inspiron/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            inputs.nix-flatpak.nixosModules.nix-flatpak
          ];
        };
        bitfenix = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/bitfenix/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            inputs.nix-flatpak.nixosModules.nix-flatpak
          ];
        };
        # add here other machines
      };
    };
}
