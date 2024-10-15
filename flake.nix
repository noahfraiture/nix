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
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  {
    nixosConfigurations = {
      inspiron = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          {
            nixpkgs.overlays = [ inputs.hyprpanel.overlay ];
            _module.args = { inherit inputs; };
          }
          ./hosts/inspiron/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
        ];
      };
      # add here other machines
    };
  };
}
