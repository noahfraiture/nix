{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # pokemon-colorscripts-mac # Display pokemon
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
        identityFile = "/home/noah/.ssh/github";
      };
    };
    # TODO : ssh config
  };
  services.ssh-agent.enable = true;
}
