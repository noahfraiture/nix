{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

let
  pinScript = pkgs.pkgs.writeShellScriptBin "pin" ''
    # enable float
    WinFloat=$(hyprctl -j clients | jq '.[] | select(.focusHistoryID == 0) | .floating')
    WinPinned=$(hyprctl -j clients | jq '.[] | select(.focusHistoryID == 0) | .pinned')

    if [ "$WinFloat" == "false" ] && [ "$WinPinned" == "false" ] ; then
        hyprctl dispatch togglefloating active
    fi

    # toggle pin
    hyprctl dispatch pin active

    # disable float
    WinFloat=$(hyprctl -j clients | jq '.[] | select(.focusHistoryID == 0) | .floating')
    WinPinned=$(hyprctl -j clients | jq '.[] | select(.focusHistoryID == 0) | .pinned')

    if [ "$WinFloat" == "true" ] && [ "$WinPinned" == "false" ] ; then
        hyprctl dispatch togglefloating active
    fi
  '';

  zenScript = pkgs.pkgs.writeShellScriptBin "zen" ''
    FILE="${config.home.homeDirectory}/.config/hypr/zen.conf"
    SIZE=$(wc -c <"$FILE")
    MIN=2
    if [ $MIN -ge $SIZE ]; then
      cat << 'EOF' > $FILE
    animations { 
      enabled=false
    }
    general {
      border_size=1
      gaps_in=0
      gaps_out=0
    }
    decoration {
      blur {
        enabled=false
      }
      active_opacity=1
      inactive_opacity=1
      rounding=0
    }
    EOF
    else
      > "$FILE"
    fi
  '';

  term = "${pkgs.kitty}/bin/kitty";
  browser = "${pkgs.opera}/bin/opera";

in
{
  options = {
    zen.enable = lib.mkEnableOption "Zen mode";
    hyprlock.enable = lib.mkEnableOption "Instant hyprlock";
  };

  config = {

    home.packages = [
      inputs.hyprpolkitagent.packages."${pkgs.system}".hyprpolkitagent
      pkgs.cliphist
      pkgs.playerctl
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      plugins = [ inputs.hyprspace.packages.${pkgs.system}.Hyprspace ];

      sourceFirst = false;

      settings = {

        monitor = [
          "eDP-1, 2560x1600@120, 0x500, 1.25"
          "DP-3, 3440x1440@100, 2048x0, 1"
          "HDMI-A-2, 1920x1080, 5488x200, 1"
        ];

        exec-once = [
          "hyprctl setcursor Qogir 24"
          "systemctl --user start hyprpolkitagent"
          "sleep 3 && swww-daemon"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
        ] ++ (if config.hyprlock.enable then [ "${pkgs.hyprlock}/bin/hyprlock --immediate" ] else [ ]);

        plugin = {
          overview = {
            autoDrag = false;
          };
        };

        input = {
          kb_options = "caps:swapescape";
          kb_layout = "us";
          kb_variant = "altgr-intl";

          touchpad = {
            natural_scroll = true;
            scroll_factor = 0.7;
            disable_while_typing = false;
          };
        };

        gestures = {
          workspace_swipe = true;
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
          smart_split = true;
        };

        workspace = [
          "w[t1], gapsin:0, gapsout:0, border:0"
          "w[tg1], gapsin:0, gapsout:0, border:0"
          "f[1], gapsin:0, gapsout:0, border:0"
        ];

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          force_default_wallpaper = 0;
        };

        general =
          if config.zen.enable then
            {
              border_size = 1;
              gaps_in = 0;
              gaps_out = 0;
              resize_on_border = true;
            }
          else
            {
              border_size = 2;
              gaps_in = 3;
              gaps_out = 8;
              resize_on_border = true;
            };

        decoration =
          if config.zen.enable then
            {
              active_opacity = 1;
              inactive_opacity = 1;
              blur.enabled = false;

            }
          else
            {
              rounding = 10;
              active_opacity = 0.9;
              inactive_opacity = 0.9;

              blur = {
                enabled = true;
                size = 6;
                passes = 5;
                xray = false;
              };
            };

        animations = {
          enabled = !config.zen.enable;
          bezier = [
            "wind, 0.05, 0.9, 0.1, 1.05"
            "winIn, 0.1, 1.1, 0.1, 1.1"
            "winOut, 0.3, -0.3, 0, 1"
            "liner, 1, 1, 1, 1"
          ];
          animation = [
            "windows, 1, 4, wind, popin"
            "windowsIn, 1, 4, winIn, popin"
            "windowsOut, 1, 4, winOut, popin"
            "windowsMove, 1, 4, wind, popin"
            "border, 1, 1, liner"
            "fade, 1, 8, default"
            "workspaces, 1, 4, wind"
          ];
        };

        xwayland.force_zero_scaling = true;

        "$mod" = "SUPER";

        bindm = [
          # Move/Resize focused window
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        bind = [
          # Window/Session actions
          "$mod, Q, killactive"
          "$mod, Delete, exit," # kill hyprland session
          "$mod, D, togglefloating," # toggle the window between focus and float
          "$mod, G, togglegroup," # toggle the window between focus and group
          "$mod, F, fullscreen," # toggle the window between focus and fullscreen
          ''$mod, P, exec, ${pinScript}/bin/pin'' # toggle pin on focused window
          "$mod, B, exec, hyprctl setprop active opaque toggle" # toggle opaque on window
          "$mod, ESCAPE, exec, hyprpanel -b hypr -t powermenu"
          "$mod, TAB, overview:toggle"
          ''$mod, Z, exec, ${zenScript}/bin/zen'' # Zen mode

          # Applications shortcuts
          "$mod, T, exec, ${term}"
          "$mod, O, exec, ${browser}"

          "$mod, SPACE, exec, ags -t app-launcher"
          "$mod, W, exec, ags -t wallpaper-switcher"
          "$mod, C, exec, ags -t color-switcher"
          # TODO : swww + wallbash or stylix to change theme
          # TODO : clipboard

          # === WINDOWS MANAGEMENTS - Super (Shift to drag) ===

          # Move/Change window focus (can cross monitors)
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # Move focused window (can cross monitors)
          "$mod&Shift_L, h, movewindow, l"
          "$mod&Shift_L, l, movewindow, r"
          "$mod&Shift_L, k, movewindow, u"
          "$mod&Shift_L, j, movewindow, d"

          # Resize windows
          "$mod, code:21, resizeactive, 30 -30"
          "$mod, code:20, resizeactive, -30 30"

          # Toggle focused window split
          "$mod, M, togglesplit"

          # === WORKSPACE MANAGEMENTS - Super + Ctrl (Shift to drag) (Alt to lock monitor) ===

          # THIS IS AN EXCEPTION
          # Switch workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Switch workspaces to a relative workspace
          "$mod&Control_L, l, workspace, +1"
          "$mod&Control_L, h, workspace, -1"
          # In current monitor
          "$mod&Control_L&Alt_L, l, workspace, r+1"
          "$mod&Control_L&Alt_L, h, workspace, r-1"

          # Move to the first empty workspace
          "$mod&Control_L, j, workspace, empty "

          # Move focused window to a relative workspace
          "$mod&Control_L&Shift_L, l, movetoworkspace, +1"
          "$mod&Control_L&Shift_L, h, movetoworkspace, -1"
          # In current monitor
          "$mod&Control_L&Shift_L&Alt_L, l, movetoworkspace, r+1"
          "$mod&Control_L&Shift_L&Alt_L, h, movetoworkspace, r-1"

          # Move/Switch to special workspace (scratchpad)
          "$mod&Control_L&Shift_L, S, movetoworkspace, special"
          "$mod&Control_L, S, togglespecialworkspace,"

          # Move focused window to a workspace
          "$mod&Control_L&Shift_L, 1, movetoworkspace, 1"
          "$mod&Control_L&Shift_L, 2, movetoworkspace, 2"
          "$mod&Control_L&Shift_L, 3, movetoworkspace, 3"
          "$mod&Control_L&Shift_L, 4, movetoworkspace, 4"
          "$mod&Control_L&Shift_L, 5, movetoworkspace, 5"
          "$mod&Control_L&Shift_L, 6, movetoworkspace, 6"
          "$mod&Control_L&Shift_L, 7, movetoworkspace, 7"
          "$mod&Control_L&Shift_L, 8, movetoworkspace, 8"
          "$mod&Control_L&Shift_L, 9, movetoworkspace, 9"
          "$mod&Control_L&Shift_L, 0, movetoworkspace, 10"

          # Move focused window to a workspace silently
          "$mod&Control_L, 1, workspace, 1"
          "$mod&Control_L, 2, workspace, 2"
          "$mod&Control_L, 3, workspace, 3"
          "$mod&Control_L, 4, workspace, 4"
          "$mod&Control_L, 5, workspace, 5"
          "$mod&Control_L, 6, workspace, 6"
          "$mod&Control_L, 7, workspace, 7"
          "$mod&Control_L, 8, workspace, 8"
          "$mod&Control_L, 9, workspace, 9"
          "$mod&Control_L, 0, workspace, 10"
        ];

        bindl = [
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause" # Play/Pause Song
          ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next" # Next Song
          ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous" # Previous Song
          ",switch:Lid Switch, exec, ${pkgs.hyprlock}/bin/hyprlock" # Lock when closing Lid
        ];

        bindle = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86MonBrightnessUp, exec, brightnessctl set +5%" # Brightness Up
          ",XF86MonBrightnessDown, exec, brightnessctl set 5%-" # Brightness Down
        ];

        source = [
          "~/.config/hypr/zen.conf"
        ];
      };
    };
  };
}
