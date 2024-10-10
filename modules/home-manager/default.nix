{ pkgs, lib, config, ... }:

{
  imports = [
    ./shell/default.nix
    ./wm/default.nix
    ./gui/default.nix
  ];
}
