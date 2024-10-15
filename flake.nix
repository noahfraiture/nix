{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    # TODO : see hyprspace
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
  
    nixosConfigurations = {
      inspiron = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/inspiron/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
      # add here other machines
    };
  };
}
