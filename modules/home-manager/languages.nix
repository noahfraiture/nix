{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    python3
    cargo
    deno # TODO : update 2.0
    go # TODO : update to 1.23 ?
  ];
}
