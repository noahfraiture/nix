{ config, pkgs, ... }:

let
  theme = ''
    # The basic colors
    foreground              #${config.lib.stylix.colors.base05}
    background              #${config.lib.stylix.colors.base00}
    selection_foreground    #${config.lib.stylix.colors.base00}
    selection_background    #${config.lib.stylix.colors.base06}

    # Cursor colors
    cursor                  #${config.lib.stylix.colors.base06}
    cursor_text_color       #${config.lib.stylix.colors.base00}

    # URL underline color when hovering with mouse
    url_color               #${config.lib.stylix.colors.base06}

    # Kitty window border colors
    active_border_color     #${config.lib.stylix.colors.base07}
    # FIXME : approximation
    inactive_border_color   #${config.lib.stylix.colors.base04}
    bell_border_color       #${config.lib.stylix.colors.base0A}

    # OS Window titlebar colors
    wayland_titlebar_color system
    macos_titlebar_color system

    # Tab bar colors
    # FIXME : approximation
    active_tab_foreground   #${config.lib.stylix.colors.base01}
    active_tab_background   #${config.lib.stylix.colors.base0E}
    inactive_tab_foreground #${config.lib.stylix.colors.base05}
    inactive_tab_background #${config.lib.stylix.colors.base01}
    # FIXME : approximation
    tab_bar_background      #${config.lib.stylix.colors.base01}

    # Colors for marks (marked text in the terminal)
    mark1_foreground #${config.lib.stylix.colors.base00}
    mark1_background #${config.lib.stylix.colors.base07}
    mark2_foreground #${config.lib.stylix.colors.base00}
    mark2_background #${config.lib.stylix.colors.base0E}
    mark3_foreground #${config.lib.stylix.colors.base00}
    mark3_background #${config.lib.stylix.colors.base0C}

    # The 16 terminal colors

    # black
    color0 #${config.lib.stylix.colors.base03}
    color8 #${config.lib.stylix.colors.base04}

    # red
    color1 #${config.lib.stylix.colors.base08}
    color9 #${config.lib.stylix.colors.base08}

    # green
    color2  #${config.lib.stylix.colors.base0B}
    color10 #${config.lib.stylix.colors.base0B}

    # yellow
    color3  #${config.lib.stylix.colors.base0A}
    color11 #${config.lib.stylix.colors.base0A}

    # blue
    color4  #${config.lib.stylix.colors.base0D}
    color12 #${config.lib.stylix.colors.base0D}

    # magenta
    color5  #${config.lib.stylix.colors.base06}
    color13 #${config.lib.stylix.colors.base06}

    # cyan
    color6  #${config.lib.stylix.colors.base0C}
    color14 #${config.lib.stylix.colors.base0C}

    # white
    # FIXME : approximation
    color7  #${config.lib.stylix.colors.base05}
    # FIXME : approximation
    color15 #${config.lib.stylix.colors.base04}
  '';

  font = "${config.stylix.fonts.monospace.name}";
  fontSize = config.stylix.fonts.sizes.terminal;
in
{
  stylix.targets.kitty.enable = false;

  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+shift+esc" = "no_op";
      "ctrl+shift+t" = "no_op";
      "ctrl+equal" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+backspace" = "send_text all \\x17";
    };

    font.name = font;
    font.size = fontSize;

    extraConfig = theme;
  };

  home.packages = with pkgs; [
    kitty
  ];
}
