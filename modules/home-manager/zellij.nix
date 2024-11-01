{ pkgs, ... }:
let
  config = ''
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
  '';
in
{
  home.packages = with pkgs; [
    zellij
  ];

  stylix.targets.zellij.enable = false;

  programs.zellij = {
    enable = true;
  };
  home.file.zellij = {
    target = ".config/zellij/config.kdl";
    text = config;
  };
}
