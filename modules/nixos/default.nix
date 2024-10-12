{ pkgs, lib, config, ... }:

{
  imports = [
  ];

  users.users.noah.packages = with pkgs; [
    python3
    cargo
    deno # TODO : update 2.0
    go # TODO : update to 1.23 ?

    # TODO : remove with jdt-language-server and put in a nixshell alias
    clang
    jdk
  ];
}
