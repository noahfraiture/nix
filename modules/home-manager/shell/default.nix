{ pkgs, lib, config, ... }:

{
  imports = [
    ./kitty.nix
    ./zsh.nix
    ./helix.nix
  ];

  home.packages = with pkgs; [
    kitty
    lazygit
  ];

  programs.lazygit = {
    enable = true;
  };
}
