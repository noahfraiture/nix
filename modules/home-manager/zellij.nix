{ pkgs, ... }:

{
  programs.zellij= {
    enable = true;

    settings = {
      keybinds = {
        shared = [
          ''unbind "Ctrl s"''
          ''bind "Alt s" { SwitchToMode "Scroll"; }''

          ''unbind "Ctrl h"''
          ''bind "Alt m" { SwitchToMode "move"; }''

          ''unbind "Ctrl o"''
          ''bind "Alt o" { SwitchToMode "session"; }''

          ''unbind "Ctrl p"''
          ''bind "Alt p" { SwitchToMode "pane"; }''

          ''unbind "Ctrl g"''
          ''bind "Alt g" { SwitchToMode "Locked"; }''

          ''unbind "Ctrl t"''
          ''bind "Alt t" { SwitchToMode "tab"; }''

          ''unbind "Ctrl n"''
          ''bind "Alt n" { NewPane; }''
          ''bind "Alt r" { SwitchToMode "resize"; }''

          ''unbind "Ctrl q"''
          ''bind "Alt q" { Quit; }''
          ''bind "Alt w" { Detach; }''

          ''bind "Alt f" { ToggleFocusFullscreen; }''
          ''bind "Alt c" { Clear; }''
        ];
        pane = [
          ''bind "h" { NewPane "Left"; }''
          ''bind "j" { NewPane "Down"; }''
          ''bind "k" { NewPane "Up"; }''
          ''bind "l" { NewPane "Right"; }''
        ];
        locked  = [
          ''bind "Alt g" { SwitchToMode "Normal"; }''
        ];
      };
      plugins = [
        ''tab-bar location="zellij:tab-bar"''
        ''status-bar location="zellij:status-bar"''
        ''strider location="zellij:strider"''
        ''compact-bar location="zellij:compact-bar"''
        ''session-manager location="zellij:session-manager"''
        ''welcome-screen location="zellij:session-manager" { welcome_screen true }''
        ''filepicker location="zellij:strider" { cwd "/" }''
      ];
    };
  };

  home.packages = with pkgs; [
    zellij
  ];
}
