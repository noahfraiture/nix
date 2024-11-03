## This:
# # pkgs = import (builtins.fetchTarball {
##       url = "https://github.com/NixOS/nixpkgs/archive/23c10dbe320e6957f2607d8a22f9e0e36f56a235.tar.gz";
##  }) {};
## Once you get the hang of things I would recommend you to do this. Then it means, whoever uses your `shell.nix` file be it now or in the future will have the exact same setup.

let
   # First I specify which beam packages base package I want to use to
   # base my overrides on. In this case erlang_27 
   packages = beam.packagesWith beam.interpreters.erlang_27;

   # Then I override the elixir package by fetching from github.
   # If you try with a new version, make sure to change the sha256 slightly
   # otherwise nix is "smart" enough to pick up the version which matches the hash
   elixir = packages.elixir.overrideAttrs(old: {
     name = "elixir-1.17.2";
     src = fetchFromGitHub { 
       rev = "v1.17.2";
       sha256 = "sha256-8rb2f4CvJzio3QgoxvCv1iz8HooXze0tWUJ4Sc13dxg=";
       owner = "elixir-lang";
       repo = "elixir";
     };
   });

   # And often I also want to compile elixir-ls with the new elixir version
   elixir_ls = packages.elixir-ls.override {
     elixir = elixir;
     mixRelease = packages.mixRelease.override { elixir = elixir; };
   };

   # Then I specify my development packages
   basePackages = [
     elixir
     elixir_ls
     lexical
     packages.erlang
   ];
  PROJECT_ROOT = builtins.toString ./.;

  hooks = ''
    mkdir -p .nix-mix
    mkdir -p .nix-hex
    export MIX_HOME=${PROJECT_ROOT}/.nix-mix
    export HEX_HOME=${PROJECT_ROOT}/.nix-hex
    export PATH=$MIX_HOME/bin:$PATH
    export PATH=$HEX_HOME/bin:$PATH
    export LANG=en_NZ.UTF-8
    export ERL_AFLAGS="-kernel shell_history enabled"
    '';

  in mkShell {
    buildInputs = basePackages;
    shellHook = hooks;
  }
