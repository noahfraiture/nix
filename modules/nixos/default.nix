{ pkgs, lib, config, ... }:

{
  imports = [ ];

  users.users.noah.packages = with pkgs; [ ];
}
