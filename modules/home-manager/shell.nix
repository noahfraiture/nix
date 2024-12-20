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
    enable = false;
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
        identityFile = "/home/noah/nix/ssh/github";
      };
      "hostinger" = {
        user = "noah";
        hostname = "";
        identityFile = "/home/noah/nix/ssh/hostinger";
      };
      "askdia" = {
        user = "noah";
        hostname = ""; # TODO : ad
        identityFile = "/home/noah/nix/ssh/askdia";
      };
      "bitfenix" = {
        user = "noah";
        hostname = "100.74.217.51";
        identityFile = "/home/noah/nix/ssh/bitfenix";
      };
      "studssh" = {
        user = "nfraiture";
        hostname = "studssh.info.ucl.ac.be";
        identityFile = "/home/noah/nix/ssh/studssh";
      };
      "didac" = {
        user = "nfraiture";
        hostname = "didac13.info.ucl.ac.be";
        identityFile = "/home/noah/nix/ssh/studssh";
        proxyJump = "studssh";
      };
      "forge" = {
        user = "git";
        hostname = "forge.uclouvain.be";
        IdentityFile = "/home/noha/nix/ssh/forge";
      };
    };
  };
  services.ssh-agent.enable = true;
}
