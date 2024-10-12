{ pkgs, lib, config, ... }:

{
  imports = [
    ./shell/default.nix
    ./wm/default.nix
    ./gui.nix
    ./development.nix
    ./languages.nix
  ];
}
