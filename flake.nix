{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    stylix.url = "github:danth/stylix?rev=63426a59e714c4389c5a8e559dee05a0087a3043";
  };

  outputs = { self, nixpkgs, ... }@inputs: {

    # home-manager modules, will be injected in configuration and then
    # used in home-manager.nix
    homeManagerModules.default = ./modules/home-manager;
  
    nixosConfigurations = {
      inspiron = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/inspiron/configuration.nix
          ./modules/nixos/default.nix
          inputs.stylix.nixosModules.stylix
        ];
      };
      # add here other machines
    };
  };
}
