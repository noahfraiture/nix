{ pkgs, lib, config, ... }:

{
  imports = [
  ];

  users.users.noah.packages = with pkgs; [
    python3
    # cargo
    deno
    clang
    go # TODO : update to 1.23 ?
    jdk
  ];
}
