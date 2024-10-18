{ pkgs,  ... }:

let
zellijCfg = ''
keybinds {
  shared {
    unbind "Ctrl s"
    bind "Alt s" { SwitchToMode "search"; }

    unbind "Ctrl h"
    bind "Alt m" { SwitchToMode "move"; }

    unbind "Ctrl o"
    bind "Alt o" { SwitchToMode "session"; }

    unbind "Ctrl p"
    bind "Alt p" { SwitchToMode "pane"; }

    unbind "Ctrl g"
    bind "Alt g" { SwitchToMode "Locked"; }

    unbind "Ctrl t"
    bind "Alt t" { SwitchToMode "tab"; }

    unbind "Ctrl n"
    bind "Alt n" { NewPane; }
    bind "Alt r" { SwitchToMode "resize"; }

    unbind "Ctrl q"
    bind "Alt w" { Detach; }

    bind "Alt f" { ToggleFocusFullscreen; }
    bind "Alt c" { Clear; }
  }
  pane {
    bind "h" { NewPane "Left"; }
    bind "j" { NewPane "Down"; }
    bind "k" { NewPane "Up"; }
    bind "l" { NewPane "Right"; }
  }
  shared_except "locked" {
    bind "Alt q" { Quit; }
  }
  locked {
    bind "Alt g" { SwitchToMode "Normal"; }
  }
  search {
    bind "s" { SwitchToMode "EnterSearch"; SearchInput 0;}
  }
}

plugins {
  tab-bar location="zellij:tab-bar"
  status-bar location="zellij:status-bar"
  strider location="zellij:strider"
  compact-bar location="zellij:compact-bar"
  session-manager location="zellij:session-manager"
  welcome-screen location="zellij:session-manager" { welcome_screen true }
  filepicker location="zellij:strider" { cwd "/" }
}
'';
in {
  home.packages = with pkgs; [
    # pokemon-colorscripts-mac # Display pokemon
    starship                 # Shell theme
    lshw                     # Display information about gpu
    zoxide                   # Smarter cd
];

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  # FIX : build be ended up with broken config
  # home.file = lib.mkForce {
  #   ".config/zellij/config.kdl".text = zellijCfg;
  # };

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
