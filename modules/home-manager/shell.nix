{ pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
    carapace # shell completion
    fastfetch
    gdu
    lazydocker
    lazygit
    starship
    nvtopPackages.full
    pokemon-colorscripts-mac
    powertop
    rofi-wayland
    zoxide
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      os.editPreset = "hx";
      services."github.com" = "github:github.com";
      notARepository = "skip";
    };
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;
    configFile.text = ''

    '';
    # TODO : add pokemon
    loginFile.text = ''
    if (tty) == "/dev/tty1" {
      echo "Hello mom !"
    }
    echo "always"
    '';

    shellAliases = {
      lg = "lazygit";
      update = "sudo nixos-rebuild switch --flake /etc/nixos/#inspiron";
      cd = "__zoxide_z";
      cdi = "__zoxide_zi";
    };
  };

  # Man page completion
  programs.man.generateCaches = true;

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
