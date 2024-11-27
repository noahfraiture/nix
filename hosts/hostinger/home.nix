{ pkgs, ... }:
{
  home = {
    username = "noah";
    homeDirectory = "/home/noah";
    stateVersion = "24.05";
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  imports = [
    ../../modules/home-manager/helix.nix
    ../../modules/home-manager/nushell.nix
    # TODO : currently nixos/stylix.nix and home-manager/stylix are duplicated. Fix that
    ../../modules/home-manager/stylix.nix
    ../../modules/home-manager/packages.nix
    ../../modules/home-manager/shell.nix
    ../../modules/home-manager/starship.nix
    ../../modules/home-manager/zellij.nix
  ];

  home.packages = [ pkgs.dconf ];

  gui.enable = false;
  shell.enable = true;
  language.enable = true;
  exegol.enable = false;
  wakatime.enable = false;
  lazygit.enable = true;
  

  programs.home-manager.enable = true;
}
