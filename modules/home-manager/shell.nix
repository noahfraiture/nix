{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # pokemon-colorscripts-mac # Display pokemon
    lshw # Display information about gpu
    zoxide # Smarter cd
  ];

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;
    configFile.text = ''
      $env.config = {
        show_banner: false
        edit_mode: vi
      }
      $env.EDITOR = "hx"
      $env.VISUAL = "hx"
    '';

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos/#inspiron";
      lg = "lazygit";
      ld = "lazydocker";
      cd = "__zoxide_z";
      cdi = "__zoxide_zi";
      icat = "kitten icat";
      ssh = "kitten ssh";
    };
  };

  # Man page completion
  programs.man.generateCaches = true;

  # Shell history
  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
  };

  # Completion multi-shell
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
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
