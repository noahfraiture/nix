{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    zoxide # Smarter cd
  ];

  programs.zoxide.enable = true;

  # Shell history
  programs.atuin = {
    enable = true;
    flags = [
      "--disable-up-arrow"
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Noah";
    userEmail = "pro@noahcode.dev";
    extraConfig = {
      init.defaultBranch = "main";
      github.user = "NoahFraiture";
      pull.rebase = true;
    };
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        user = "git";
        hostname = "github.com";
        identityFile = "/home/noah/Nix/ssh/github";
      };
      "hostinger" = {
        user = "noah";
        hostname = "127.0.0.1";
        identityFile = "/home/noah/Nix/ssh/hostinger";
      };
      "askdia" = {
        user = "noah";
        hostname = "127.0.0.1";
        identityFile = "/home/noah/Nix/ssh/askdia";
      };
      "bitfenix" = {
        user = "noah";
        hostname = "100.74.217.51";
        identityFile = "/home/noah/Nix/ssh/bitfenix";
      };
      "studssh" = {
        user = "nfraiture";
        hostname = "studssh.info.ucl.ac.be";
        identityFile = "/home/noah/Nix/ssh/studssh";
      };
      "didac" = {
        user = "nfraiture";
        hostname = "didac13.info.ucl.ac.be";
        identityFile = "/home/noah/Nix/ssh/studssh";
        proxyJump = "studssh";
      };
      "forge" = {
        user = "git";
        hostname = "forge.uclouvain.be";
        identityFile = "/home/noah/Nix/ssh/forge";
      };
    };
  };
  services.ssh-agent.enable = true;
}
