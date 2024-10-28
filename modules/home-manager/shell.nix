{
  pkgs,
  lib,
  config,
  ...
}:
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

      def rebuild [name] = {sudo nixos-rebuild switch --flake $"/etc/nixos/#($name)"}

      def awake [name] = {
        match $name {
          "bitfenix" => { wol d8:bb:c1:52:6c:f0 }
          _ => "MAC not known"
        }
      }

      def theme [ color ] = {
        sudo /nix/var/nix/profiles/system/specialisation/($color)/bin/switch-to-configuration switch
        ps | find hx | select pid | each { sudo kill -s 10 $in.pid | ignore }
      }
    '';

    shellAliases = {
      lg = lib.mkIf config.lazygit.enable "lazygit";
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
