{ pkgs, lib, config, ... }:

{
  imports = [
    ./kitty.nix
    ./zsh.nix
    ./helix.nix
  ];

  home.packages = with pkgs; [
    lazygit
    btop
    eza
    fastfetch
    gdu
    nvtopPackages.full
    pokemon-colorscripts-mac
    powertop
    zoxide
  ];

  programs.lazygit = {
    enable = true;
  };
}
